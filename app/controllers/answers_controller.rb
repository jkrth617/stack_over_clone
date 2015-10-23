class AnswersController < ApplicationController

  def show
    @question = Question.find(params[:question_id])
  end

  def create
    question = Question.find(params[:question_id])
    @answer = Answer.new(answers_params)
    if @answer.save
    else
    end
    redirect_to question
  end

  def answers_params
    params.require(:answer).permit(:body, :user_id, :question_id)
  end

end
