class AppSession < ActiveRecord::Base
  belongs_to :app_instance
  has_many :app_events
  has_many :app_captures

  validates :app_instance_id, presence: true
  validates :start_time, presence: true
  validates :last_event_time, presence: true
end
