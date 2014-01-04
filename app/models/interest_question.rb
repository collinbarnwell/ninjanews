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
  validates :question_text, presence: true
  has_many :relation_levels, dependent: :destroy
  has_many :interest_answers, dependent: :destroy
end
