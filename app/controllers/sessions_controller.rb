class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Successfully logged in"
      redirect_to root_path
    else
      flash.now.alert = "Mismatched username/password"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end
end
