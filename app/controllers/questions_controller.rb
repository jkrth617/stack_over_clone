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
    if current_user
      if new_q.valid?
        current_user.questions << new_q
        binding.pry
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
    @question = Question.find(params[:id])
  end

  def update
  end

  def vote
    parent_question = Question.find_by(id: params[:question_id])
    vote = Vote.new(user_id: session[:user_id], voteable: parent_question, value: params[:vote_direction])
    vote = vote.value_check
    if vote.save
      redirect_to :back
    else
      flash[:errors] = "your vote didn't process"
      redirect_to :back
    end
  end

  def valid_params
    params.require(:question).permit(:title,:body)
  end

end
