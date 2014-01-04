class StaticPagesController < ApplicationController
  def home
    if current_user
      redirect_to current_user
    else
      redirect_to signin_path
    end
  end
end
