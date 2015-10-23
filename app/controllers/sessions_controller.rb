class SessionsController < ApplicationController
  def login_form
    render 'sessions/new'
  end
  def login
    user = User.find_by(username: session_params[:username])
    if user.try(:authenticate, session_params[:password])
      session[:user_id] = user.id
      flash[:message] = "Successfully logged in!"
      redirect_to root_path
    else
      flash[:errors] = "Mismatched username/password"
      redirect_to login_path
    end
  end

  def logout
    session.clear
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
