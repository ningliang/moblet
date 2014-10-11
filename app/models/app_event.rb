class AppEvent < ActiveRecord::Base
  belongs_to :app_session

  validates :app_session_id, presence: true
  validates :name, presence: true
  validates :params, presence: true
  validates :device_time, presence: true
end
