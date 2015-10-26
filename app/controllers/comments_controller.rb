class CommentsController < ApplicationController
  def new
    @answer = Answer.find(params[:answer_id])
    @comment = Comment.new
    if request.xhr?
      render 'comments/new', layout: false
    else
      render 'comments/new'
    end
  end

  def create
    answer = Answer.find(params[:answer_id])
    new_comment = Comment.new(valid_params)
    if request.xhr?
      comment_creation_Async(answer, new_comment)
    else
      comment_creation_sync(answer, new_comment)
    end
  end

  def comment_creation_Async(answer, new_comment)
    if current_user
      if new_comment.valid?
        answer.comments << new_comment
        render partial: 'comments/comment', layout: false, locals:{comment: new_comment}
      else
        render :nothing => true, :status => 500
      end
    else
      render :nothing => true, :status => 403
    end
  end

  def comment_creation_sync(answer, new_comment)
    if current_user
      if new_comment.valid?
        answer.comments << new_comment
        redirect_to question_path(answer.question_id)
      else
        flash[:errors] = new_comment.errors.messages.values.join("\n")
        redirect_to new_answer_comment_path
      end
    else
      flash[:errors] = "You must be logged in to add answers."
      redirect_to new_answer_comment_path
    end
  end

  def valid_params
    params.require(:comment).permit(:body,:user_id, :answer_id)
  end

end
