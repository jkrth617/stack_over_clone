class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
    if request.xhr?
      render 'answers/new', layout: false
    else
      render 'answers/new'
    end
  end

  def create
    question = Question.find(params[:question_id])
    new_a = Answer.new(valid_params)
    if request.xhr?
      answer_creation_Async(question, new_a)
    else
      answer_creation_sync(question, new_a)
    end
  end

  def vote
    parent_answer = Answer.find_by(id: params[:answer_id])
    make_vote(parent_answer)
  end

  def answer_creation_sync(question, new_a)
    if current_user
      if new_a.valid?
        question.answers << new_a
        redirect_to question
      else
        flash[:errors] = new_q.errors.messages.values.join("\n")
        redirect_to new_question_answer_path(question)
      end
    else
      flash[:errors] = "You must be logged in to add answers."
      redirect_to new_question_answer_path
    end
  end


  def valid_params
    params.require(:answer).permit(:body, :user_id, :question_id)
  end
end
