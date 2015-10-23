class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, touch: true
  has_many :votes, as: :voteable, dependent: :destroy

  validates_presence_of :body, :question_id ,:user_id

  def total_points#really slow have the bd do this later
    self.votes.sum(:value)
  end

  def self.by_recency
    order(updated_at: :desc)
  end

end
