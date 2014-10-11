class AppInstance < ActiveRecord::Base

  belongs_to :app
  belongs_to :app_user
  has_many :app_sessions

  validates :device_type, presence: true
  validates :device_id, presence: true
  validates :app_id, presence: true
  validates :app_user_name, presence: true

  def self.find_or_create_for_client!(app, device_type, device_id, app_user_name)
    self.where(
      app: app,
      device_type: device_type,
      device_id: device_id,
      app_user_name: app_user_name
    ).first_or_create!
  end
end


# t.references :app
# t.references :app_user
# t.string :device_type
# t.string :device_id
# t.string :app_user_name
# t.timestamps
