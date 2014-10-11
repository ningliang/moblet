class AppInstance < ActiveRecord::Base
  belongs_to :app
  belongs_to :app_user
  has_many :app_sessions

  validates :device_type, presence: true
  validates :device_id, presence: true
  validates :app_id, presence: true
  validates :app_user_id, presence: true
end
