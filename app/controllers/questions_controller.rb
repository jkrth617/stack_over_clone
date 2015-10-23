class QuestionsController < ApplicationController
  def index
    @questions = Question.order(id: :desc)
  end

  def edit
  end

  def new
    @question = Question.new
  end

  def create
    new_q = Question.new(valid_params)
    binding.pry
    if current_user
      if new_q.valid?
        current_user.questions << new_q
        redirect_to questions_path
      else
        flash[:errors] = new_q.errors.messages.values.join("\n")
        redirect_to new_question_path
      end
    else
      flash[:errors] = "You must be logged in to create questions."
      redirect_to new_question_path
    end
  end

  def show
  end

  def update
  end

  def valid_params
    params.require(:question).permit(:title,:body)
  end
end
