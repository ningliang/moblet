class App < ActiveRecord::Base
  has_many :app_instances

  validates :api_key, presence: true
  validates :name, presence: true
end
