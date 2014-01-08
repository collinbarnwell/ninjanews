class SessionsController < ApplicationController
  def new
  end

  def create
    redirect_to current_user if signed_in?
    user = User.from_omniauth(env["omniauth.auth"])
    if user.new_record?
      user.save!
      session[:user_id] = user.id
      redirect_to edit_user_path(user)
    else
      user.save!
      session[:user_id] = user.id
      redirect_to user
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
