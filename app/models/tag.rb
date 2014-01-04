class Tag < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_and_belongs_to_many :articles
end
