class FriendshipsController < ApplicationController
  def create
    @user = current_user
    @friend = User.find_by(email: params[:email])
    if @friend
      @friendship = Friendship.create!(user_id: @user.id, friend_id: @friend.id)
      redirect_to dashboard_index_path
    else
      flash[:error] = "Friend not found."
      redirect_to dashboard_index_path
    end
  end
end
