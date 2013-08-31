class InterestQuestion < ActiveRecord::Base
  has_many :feeds, through: :relation_levels
  has_many :interest_answers
end