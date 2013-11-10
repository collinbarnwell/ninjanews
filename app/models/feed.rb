# == Schema Information
#
# Table name: feeds
#
#  id              :integer         not null, primary key
#  source_id       :integer
#  url             :string(255)
#  section         :string(255)
#  area_importance :integer
#  is_local_news   :boolean         default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

class Feed < ActiveRecord::Base
  has_many :interest_questions, through: :relation_levels
  has_many :articles
  has_many :feed_scores
end
