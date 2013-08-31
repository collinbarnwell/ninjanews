class Source < ActiveRecord::Base
  # attr_accessible :area, :name, :url
  
  validates_presence_of :name, :url

  has_many :feeds
  has_many :articles. through: :feeds
end
