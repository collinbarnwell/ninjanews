# == Schema Information
#
# Table name: sources
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  url          :string(255)
#  area         :string(255)
#  published_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Source < ActiveRecord::Base
  validates :name, :url, presence: true

  has_many :feeds
  has_many :articles, through: :feeds
end
