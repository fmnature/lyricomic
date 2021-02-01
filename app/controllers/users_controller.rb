class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @image = user.image
    @profile = user.profile
    @lyrics = user.lyrics.order("created_at DESC")
  end
end
