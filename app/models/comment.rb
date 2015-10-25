class Comment < ActiveRecord::Base
  belongs_to :answer
  has_many :votes, as: :voteable, dependent: :destroy

  validates :body, presence: true

  def author
    User.find(self.user_id).username
  end
end
