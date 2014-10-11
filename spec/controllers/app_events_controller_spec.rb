require 'rails_helper'

RSpec.describe AppEventsController, :type => :controller do

  before(:each) do
    @test_key = "test"
    @app = App.create!(api_key: @test_key, name: "Test")
  end

  def post_event(api_key, time)
    post "create", {
      api_key: api_key,
      timestamp: time,
      app_instance: {
        device_type: "iPhone 6",
        device_id: "test_phone",
        app_user_name: "test_user"
      },
      app_event: {
        name: "test_event",
        params: "{}"
      }
    }
  end

  describe("POST /app_events") do

    it "should fail without api_key" do
      post "create"
      expect(response.code).to eq("400")
    end

    it "should establish app_instance and create app_event" do
      device_time = Time.now.round
      post_event(@test_key, device_time)
      expect(response.code).to eq("200")

      inst_query = AppInstance.where(
        app_user_name: "test_user",
        device_id: "test_phone",
        device_type: "iPhone 6"
      )
      expect(inst_query.count).to eq(1)
      inst = inst_query.first
      expect(inst.device_type).to eq("iPhone 6")
      expect(inst.device_id).to eq("test_phone")
      expect(inst.app_user_name).to eq("test_user")

      sess_query = AppSession.where(app_instance_id: inst.id)
      expect(sess_query.count).to eq(1)
      session = sess_query.first
      expect(session.start_device_time).to eq(device_time)
      expect(session.last_event_device_time).to eq(device_time)

      evt_query = AppEvent.where(app_session_id: session.id)
      expect(evt_query.count).to eq(1)
      event = evt_query.first
      expect(event.device_time).to eq(device_time)
      expect(event.name).to eq("test_event")
      expect(event.params).to eq("\"{}\"")
    end

    it "should extend a session within threshold" do
      device_time = Time.now.round
      post_event(@test_key, device_time)
      post_event(@test_key, device_time + 1.second)

      expect(AppSession.count).to eq(1)
      session = AppSession.first
      expect(session.start_device_time).to eq(device_time)
      expect(session.last_event_device_time).to eq(device_time + 1.second)
    end

    it "should create a new session outside of threshold" do
      device_time = Time.now.round
      post_event(@test_key, device_time)
      post_event(@test_key, device_time + 30.minutes)

      expect(AppSession.count).to eq(2)
    end

  end

end
