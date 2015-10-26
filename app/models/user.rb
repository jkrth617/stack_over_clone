class User < ActiveRecord::Base
  has_secure_password
  has_many :questions
  has_many :answers
  has_many :votes
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_presence_of :username, :email, :password_digest
  validates_uniqueness_of :email, :username

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["name"]
      user.email = Faker::Internet.email
      user.password = SecureRandom.urlsafe_base64
      user.profile_image = auth["info"]["image"]
    end
  end

  def from_omniauth?
    provider && uid
  end
end
