class RelationLevel < ActiveRecord::Base
  belongs_to :feed
  belongs_to :interest_question

  validates :level, inclusion: 0..5
end
