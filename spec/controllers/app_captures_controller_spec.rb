require 'rails_helper'

RSpec.describe AppCapturesController, :type => :controller do

  before(:each) do
    @test_key = "test"
    @app = App.create!(api_key: @test_key, name: "Test")
  end

  def post_capture(api_key, time)
    post "create", {
      api_key: api_key,
      timestamp: time,
      app_instance: {
        device_type: "iPhone 6",
        device_id: "test_phone",
        app_user_name: "test_user"
      },
      app_capture: {
        s3_bucket: "test_bucket",
        s3_capture_key: "test_capture_key",
        s3_thumbnail_key: "test_thumbnail_key",
        width: 100,
        height: 100,
        thumbnail_width: 10,
        thumbnail_height: 10
      }
    }
  end

  describe "POST /app_captures" do

    it "should fail without api_key" do
      post "create"
      expect(response.code).to eq("400")
    end

    it "should create app_capture" do
      device_time = Time.now.round
      post_capture(@test_key, device_time)

      expect(AppCapture.count).to eq(1)
      capture = AppCapture.first

      expect(capture.s3_bucket).to eq("test_bucket")
      expect(capture.s3_capture_key).to eq("test_capture_key")
      expect(capture.s3_thumbnail_key).to eq("test_thumbnail_key")
      expect(capture.width).to eq(100)
      expect(capture.height).to eq(100)
      expect(capture.thumbnail_width).to eq(10)
      expect(capture.thumbnail_height).to eq(10)
    end

  end

end
