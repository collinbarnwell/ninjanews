class InterestAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :interest_question

  validates :interest_rating, inclusion: 0..5
end