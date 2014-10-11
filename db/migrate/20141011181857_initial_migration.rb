# NOTE models are prefixed with "app_" because moblet itself may have sessions, users, etc. later on
# TODO separate device table, references from app_instances?
class InitialMigration < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :api_key
      t.string :name
      t.timestamps
    end

    create_table :app_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :app_user_id
      t.timestamps
    end

    create_table :app_instances do |t|
      t.references :app
      t.references :app_user
      t.string :device_type
      t.string :device_id
      t.timestamps
    end

    create_table :app_sessions do |t|
      t.references :app_instance
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end

    create_table :app_events do |t|
      t.references :app_session
      t.string :name
      t.string :params
      t.datetime :device_time
      t.timestamps
    end

    create_table :app_captures do |t|
      t.references :app_session
      t.string :s3_bucket
      t.string :s3_capture_key
      t.string :s3_thumbnail_key
      t.datetime :device_time
      t.timestamps
    end

  end
end
