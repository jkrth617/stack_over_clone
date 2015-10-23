class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic => true
  belongs_to :user

  validates_presence_of :value

  def value_check
    prev_vote = Vote.find_by(user_id: self.user_id, voteable: self.voteable)#where silently fails
    if prev_vote
      prev_vote.value += self.value unless prev_vote.value == self.value
      return prev_vote
    end
    self
  end
end
