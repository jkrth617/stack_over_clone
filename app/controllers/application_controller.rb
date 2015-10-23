class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def make_vote(parent_obj)
    if session[:user_id]
      vote = Vote.where(user_id: session[:user_id], voteable: parent_obj).first_or_initialize
      vote.value_check(params[:vote_direction].to_i)
      if vote.save
        redirect_to :back
      else
        flash[:errors] = "your vote didn't process"
        redirect_to :back
      end
    else
      flash[:errors] = "you must be logged in to vote"
      redirect_to :back
    end
  end

end
