class Tag < ActiveRecord::Base
  has_many :question_tags, dependent: :destroy

  validates_presence_of :description
end
