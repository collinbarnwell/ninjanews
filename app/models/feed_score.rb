# == Schema Information
#
# Table name: feed_scores
#
#  id         :integer         not null, primary key
#  feed_id    :integer
#  user_id    :integer
#  score      :float
#  created_at :datetime
#  updated_at :datetime
#

class FeedScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
end
