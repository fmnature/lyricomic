class LyricsController < ApplicationController
  before_action :set_lyric, only: [:edit, :show]

  def index
    @lyrics = Lyric.all.order("created_at DESC")
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
    @lyric = Lyric.find(params[:id])
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
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @lyric = Lyric.find(params[:id])
  end

  private
  def lyric_params
    params.require(:lyric).permit(:word, :text)
  end

  def set_lyric
    @lyric = Lyric.find(params[:id])
  end
end
