class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic => true
  belongs_to :user

  validates_presence_of :value

  def value_check(change)
    unless self.value == change
      self.value += change
    end
  end
end
