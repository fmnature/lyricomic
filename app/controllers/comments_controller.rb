class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to lyric_path(comment.lyric.id)
  end

  def edit
    
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, lyric_id: params[:lyric_id])
  end
end
