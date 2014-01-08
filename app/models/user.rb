# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  email            :string(255)
#  area             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  is_admin         :boolean         default(FALSE)
#  uid              :integer
#  oauth_expires_at :datetime
#  oauth_token      :string(255)
#  provider         :string(255)
#

class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 }, 
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEXP }

  has_many :interest_answers, dependent: :destroy
  has_many :interest_questions, through: :interest_answers
  has_many :article_reads, dependent: :destroy
  has_many :articles, through: :article_reads
  has_many :feed_scores, dependent: :destroy
  has_many :article_scores, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :tags, through: :subscriptions

  accepts_nested_attributes_for :interest_answers

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email = auth.info.email
    end
  end
end
