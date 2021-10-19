class UsersController < ApplicationController
  skip_before_action :require_user

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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
