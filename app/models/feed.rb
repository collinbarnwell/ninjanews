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
  validates :source, presence: true
  validates :section, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :source
  has_many :relation_levels, dependent: :destroy
  has_many :interest_questions, through: :relation_levels
  has_many :articles, dependent: :destroy
  has_many :feed_scores, dependent: :destroy

  accepts_nested_attributes_for :relation_levels
end
