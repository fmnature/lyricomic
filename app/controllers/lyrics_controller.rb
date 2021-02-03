class LyricsController < ApplicationController
  before_action :set_lyric, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @lyrics = Lyric.all.includes(:user).order("created_at DESC")
    # @likes = Like.all
  end

  def new
    @lyric = Lyric.new
  end

  def create
    @lyric = Lyric.new(lyric_params)
    if @lyric.save
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
    @comments = @lyric.comments.includes(:user)
    @like = Like.new
  end

  def search
    @lyrics = Lyric.search(params[:keyword])
  end

  private
  def lyric_params
    params.require(:lyric).permit(:word, :text, :image).merge(user_id: current_user.id)
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
