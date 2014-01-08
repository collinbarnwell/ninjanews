# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :tags, dependent: :destroy
  has_and_belongs_to_many :articles
end
