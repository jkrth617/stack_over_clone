class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic => true
  belongs_to :user

  validates_presence_of :value

  def value_check
    prev_vote = Vote.where(user_id: slef.user_id, question_id: self.question_id)#where silently fails
    if !(prev_vote.empty?)
      prev_vote.value += self.value unless prev_vote.value == self.value
      self = prev_vote
    end
  end
end
