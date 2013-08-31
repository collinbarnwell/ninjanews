class Article < ActiveRecord::Base
  # attr_accessible :content, :image, :source, :title, :url, :newspapers

  validates :content, presence: true, uniqueness: true
  validates :title, presence: true
  validates :url, presence: true

  belongs_to :feed
  has_and_belongs_to_many :newspapers
end
