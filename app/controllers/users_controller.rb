class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @lyrics = Lyric.all
    @relationship = current_user.relationships.find_by(follow_id: @user.id)  
    @set_relationship = current_user.relationships.new

    @id = @user.id
    @nickname = @user.nickname
    @image = @user.image
    @profile = @user.profile
    @lyrics = @user.lyrics.order("created_at DESC")
  end

  def edit
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end
  
end
