class UsersController < ApplicationController
  def show
    @lyrics = Lyric.includes(:user)
  end
end
