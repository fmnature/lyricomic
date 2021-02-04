class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(lyric_id: params[:lyric_id])
    lyric = Lyric.find(params[:lyric_id])
    lyric.create_notification_like!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(lyric_id: params[:lyric_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
