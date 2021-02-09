class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    @user = User.find(@comment.user_id)
    # lyric = @comment.lyric
    # lyric.create_notification_comment!(current_user, @comment.id)
    # redirect_to lyric_path(@comment.lyric.id)
  end

  def edit
  end

  def destroy
    @comment = Comment.find_by(lyric_id: params[:lyric_id], user_id: current_user.id)
    @comment.destroy
    # redirect_to lyric_path(@comment.lyric.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, lyric_id: params[:lyric_id])
  end
end
