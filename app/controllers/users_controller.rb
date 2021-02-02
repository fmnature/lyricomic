class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id) if user_signed_in?

    user = User.find(params[:id])
    @lyrics = Lyric.all
    @id = user.id
    @nickname = user.nickname
    @image = user.image
    @profile = user.profile
    @lyrics = user.lyrics.order("created_at DESC")


  end

  def edit
    @user = User.find(current_user.id)
  end
end
