class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  # attr_accessible :email, :name, :password, :password_confirmation, :newspapers

  validates :email, presence: true, length: { maximum: 100 }, 
            uniqueness: { case_sensitive: false } 
  validates :name, presence: true, length: { maximum: 100 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :zipcode, inclusion: 1000..99999

  has_many :newspapers
  has_many :interest_answers

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
