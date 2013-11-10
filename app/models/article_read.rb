# == Schema Information
#
# Table name: article_reads
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  article_id :integer
#

class ArticleRead < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
end
