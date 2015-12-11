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

  def increment_statsd(args={})
    prefix = args.fetch(:tag, "page")
    descripter = args.fetch(:minor_tag, "view_count")
    tag = prefix+"."+descripter
    stats = Statsd.new
    # binding.pry
    stats.increment(tag)
    stats.increment("page.view_count")
    true
  end

  def fake_counts
    stats = Statsd.new
    visits = []
    3.times {visits << rand(1..100)}
    stats.count("page.home", visits[0])
    stats.count("page.show", visits[1])
    stats.count("page.vote", visits[2])
    stats.count("page.total", visits.reduce(:+))
  end

  def load_test(page_specific = nil)
    tags = ["page.index","page.page1","page.page2" ]
    30.times do 
      if page_specific
        histo_helper(tags.sample)
      end
      histo_helper
    end
  end

  def histo_helper(tag = "support")
    stats = Statsd.new
    start_time = Time.now
    fake_work
    duration = Time.now - start_time
    stats.histogram(tag, duration)#, tags=['tester'])
  end

  def fake_work()
    upper_bound = rand(1..100000)
    upper_bound.times {}
    true
  end

end
