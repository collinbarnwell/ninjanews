# == Schema Information
#
# Table name: interest_answers
#
#  id                   :integer         not null, primary key
#  interest_question_id :integer
#  user_id              :integer
#  interest_rating      :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class InterestAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :interest_question

  validates :interest_rating, inclusion: 0..100
end
