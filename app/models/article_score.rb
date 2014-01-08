# == Schema Information
#
# Table name: article_scores
#
#  id         :integer         not null, primary key
#  score      :float
#  user_id    :integer
#  article_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class ArticleScore < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
end
