class User < ActiveRecord::Base
  has_secure_password
  has_many :questions
  has_many :answers
  has_many :votes

  validates_presence_of :username, :email, :password_digest, unless: -> { from_omniauth? }
  validates_uniqueness_of :email, :username
  #validates :email, format: { }
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["name"]
      user.email = Faker::Internet.email
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
  def from_omniauth?
    provider && uid 
  end
end
