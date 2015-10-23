class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, touch: true
  has_many :votes, as: :voteable, dependent: :destroy

  validates_presence_of :body, :question_id ,:user_id

end
