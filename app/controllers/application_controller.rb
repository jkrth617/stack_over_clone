class ApplicationController < ActionController::Base
      require 'statsd'

  protect_from_forgery with: :exception
  helper_method :current_user, :searched?

  def searched?
    params[:search]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def make_vote(parent_obj)
    if session[:user_id]
      vote = Vote.where(user_id: session[:user_id], voteable: parent_obj).first_or_initialize
      vote.value_check(params[:vote_direction].to_i)
      if request.xhr?
        vote_async_action(vote)
      else
        vote_sync_action(vote)
      end
    else #not logged in
      if request.xhr?
        status 403
      else
        flash[:errors] = "you must be logged in to vote"
        redirect_to :back
      end
    end
  end

  def vote_sync_action(vote)
    if vote.save
      redirect_to :back
    else
      flash[:errors] = "your vote didn't process"
      redirect_to :back
    end
  end

  def vote_async_action(vote)
    if vote.save
      render plain: "#{(vote.voteable.total_points)}"
    else
      status 400
    end
  end

  def increment_statsd
    stats = Statsd.new
    stats.increment('web.page_views')
    return true
  end

end
