# == Schema Information
#
# Table name: users
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  email                 :string(255)
#  zipcode               :integer
#  area                  :string(255)
#  password              :string(255)
#  password_confirmation :string(255)
#  password_digest       :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  remember_token        :string(255)
#  is_admin              :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 }, 
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEXP }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :zipcode, numericality: { only_integer: true }, inclusion: { in: 1000..99999 }

  has_many :interest_answers
  has_many :article_reads
  has_many :articles, through: :article_reads
  has_many :feed_scores

  accepts_nested_attributes_for :interest_answers

  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
