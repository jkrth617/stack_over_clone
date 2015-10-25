class Comment < ActiveRecord::Base
  belongs_to :answer
  has_many :votes, as: :voteable, dependent: :destroy

  validates :body, presence: true
end
