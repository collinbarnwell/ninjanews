class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @recent_newspapers = @user.newspapers.take(5)
    @newspapers = @user.newspapers
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user, notice: 'User successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        redirect_to @user, notice: 'User was successfully updated.' 
      else
        render action: "edit" 
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
