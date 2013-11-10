# == Schema Information
#
# Table name: articles
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  image      :string(255)
#  content    :string(255)
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  source_id  :integer
#  feed_id    :integer
#

class Article < ActiveRecord::Base
  belongs_to :feed
  has_many :article_reads
  has_many :users, through: :article_reads

  validates :content, presence: true, uniqueness: true
  validates :title, presence: true
  validates :url, presence: true

  scope :not_read_by, ->(user) do
    where('id NOT IN (?)', user.articles)
  end
  
  scope :read_by, ->(user) do
    where('id IN (?)', user.articles)
  end
end
