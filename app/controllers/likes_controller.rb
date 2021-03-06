class LikesController < ApplicationController
  before_action :set_lyric, only: [:create, :destroy] 

  def create
    @like = current_user.likes.create(lyric_id: params[:lyric_id])
    lyric = Lyric.find(params[:lyric_id])
    lyric.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(lyric_id: params[:lyric_id], user_id: current_user.id)
    @like.destroy
  end

  def set_lyric
    @lyric = Lyric.find(params[:lyric_id])
  end
end
