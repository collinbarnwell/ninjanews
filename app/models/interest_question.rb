# == Schema Information
#
# Table name: interest_questions
#
#  id            :integer         not null, primary key
#  question_text :text
#  created_at    :datetime
#  updated_at    :datetime
#

class InterestQuestion < ActiveRecord::Base
  has_many :feeds, through: :relation_levels
  has_many :interest_answers
end
