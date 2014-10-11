class AppUser < ActiveRecord::Base
  has_many :app_instances

  validates :email, presence: true
  validates :app_user_id, presence: true
end
