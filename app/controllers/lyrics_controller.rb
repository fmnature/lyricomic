class LyricsController < ApplicationController
  before_action :set_lyric, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @lyrics = Lyric.all.includes(:user).order("created_at DESC").page(params[:page]).without_count.per(10)
    # @like = current_user.likes.find_by(user_id: current_user.id)  
    # @likes = Like.all
  end

  def new
    @lyric = LyricsTag.new
  end

  def create
    @lyric = LyricsTag.new(lyric_params)
    if @lyric.valid?
      @lyric.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if @lyric.destroy
      redirect_to root_path
    else
      render :index
    end
  end

  def edit
  end

  def update
    if @lyric.update(lyric_params)
      redirect_to lyric_path(params[:id])
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @lyric.comments.includes(:user).order(created_at: :desc)
    @like = Like.new
  end

  def search
    return nil if params[:keyword] == ""
    # @lyrics = Lyric.search(params[:keyword])
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private
  def lyric_params
    params.require(:lyrics_tag).permit(:word, :text, :image, :name).merge(user_id: current_user.id)
  end

  def set_lyric
    @lyric = Lyric.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
