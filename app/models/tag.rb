class Tag < ActiveRecord::Base
  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags
  validates_presence_of :description

  def tag_params
    params.require(:tag).permit(:description)
  end

  def self.make_tags
    tag_params.split.map { |desc| Tag.where(description: desc).first_or_create }
  end
end
