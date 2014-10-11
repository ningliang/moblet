class AppSession < ActiveRecord::Base
  belongs_to :app_instance
  has_many :app_events
  has_many :app_captures

  SESSION_IDLE_THRESHOLD = 1.minute

  validates :app_instance_id, presence: true
  validates :start_device_time, presence: true
  validates :last_event_device_time, presence: true

  # Updates the latest device timestamp
  def self.find_and_update_or_establish_session!(app_instance, device_time)
    session = self
      .where(app_instance_id: app_instance.id)
      .where("last_event_device_time >= ?", device_time - SESSION_IDLE_THRESHOLD)
      .order("last_event_device_time DESC")
      .first

    if session
      session.last_event_device_time = [session.last_event_device_time, device_time].max
    else
      session = self.new(
        app_instance: app_instance,
        start_device_time: device_time,
        last_event_device_time: device_time
      )
    end
    session.save!
    session
  end
end
