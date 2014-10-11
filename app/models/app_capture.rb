class AppCapture < ActiveRecord::Base
  belongs_to :app_session

  validates :s3_bucket, presence: true
  validates :s3_capture_key, presence: true
  validates :s3_thumbnail_key, presence: true
  validates :device_time, presence: true
end
