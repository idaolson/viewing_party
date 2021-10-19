class FriendshipsController < ApplicationController
  def create
    @user = current_user
    friend = User.find_by(email: params[:email])
    if friend
      Friendship.create!(user_id: @user.id, friend_id: friend.id)
    else
      flash[:error] = 'Friend not found.'
    end
    redirect_to dashboard_index_path
  end
end
