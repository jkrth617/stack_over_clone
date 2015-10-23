class AnswersController < ApplicationController

  def show
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    question = Question.find(params[:question_id])
    new_a = Answer.new(valid_params)
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

  def recent
    @answers = Answer.by_recency
  end

  def valid_params
    params.require(:answer).permit(:body, :user_id, :question_id)
  end

end
