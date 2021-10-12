class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    session[:user_id] = new_user.id
    flash[:success] = "Welcome to Viewing Party, #{new_user.name}!"
    redirect_to dashboard_index_path
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Viewing Party, #{@user.name}!"
      redirect_to dashboard_index_path
    else
      flash[:error] = "Log in failed. Please try again."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
