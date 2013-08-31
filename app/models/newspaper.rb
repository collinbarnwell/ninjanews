class Newspaper < ActiveRecord::Base
  # attr_accessible :articles, :title

  has_and_belongs_to_many :articles
  belongs_to :user
end
