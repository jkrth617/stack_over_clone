class QuestionsController < ApplicationController
  
  def index
    # binding.pry #used to stop flow and call the ddog helpers to create metrics
    @questions = Question.by_recency
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
      redirect_to root_path
    else
      flash[:errors] = "You must be logged in to create questions."
      redirect_to new_question_path
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  def update
  end

  def vote
    parent_question = Question.find_by(id: params[:question_id])
    make_vote(parent_question)
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
