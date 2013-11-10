class Source < ActiveRecord::Base
  validates :name, :url, presence: true

  has_many :feeds
  has_many :articles. through: :feeds
end
