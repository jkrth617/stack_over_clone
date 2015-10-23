class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :voteable, dependent: :destroy

  validates_presence_of :body, :question_id ,:user_id

  def self.by_recency
    order(updated_at: :desc)
  end

end
