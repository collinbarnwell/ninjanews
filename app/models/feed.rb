class Feed < ActiveRecord::Base
  has_many :interest_questions, through: :relation_levels
  has_many :articles
end