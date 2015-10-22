class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy

  validates_presence_of :title, :body, :user
end
