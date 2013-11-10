# == Schema Information
#
# Table name: relation_levels
#
#  id                   :integer         not null, primary key
#  feed_id              :integer
#  interest_question_id :integer
#  score                :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class RelationLevel < ActiveRecord::Base
  belongs_to :feed
  belongs_to :interest_question

  validates :score, inclusion: 0..100
end
