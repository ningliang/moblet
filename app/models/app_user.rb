class AppUser < ActiveRecord::Base
  has_many :app_instances
end
