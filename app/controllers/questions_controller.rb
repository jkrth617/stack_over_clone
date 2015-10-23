class QuestionsController < ApplicationController
  def index
    @questions = Question.order(id: :desc)
  end

  def edit
  end

  def new
    @question = Question.new
    @tag = Tag.new
  end

  def create
    new_q = Question.new(valid_params)
    if session[:user_id]
      current_user.questions << new_q
      new_q.tags << make_tags
      binding.pry
      redirect_to root_path
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

  def recent
    @questions = Question.by_recency.limit(10)
  end

  def recent
    @questions = Question.by_recency.limit(10)
  end

  def valid_params
    params.require(:question).permit(:title,:body)
  end

  def tag_params
    params.require(:tag).permit(:description)
  end

  def make_tags
    tag_params[:description].split.map { |desc| Tag.where(description: desc).first_or_create }
  end

end
