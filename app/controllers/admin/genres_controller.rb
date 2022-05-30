class Admin::GenresController < ApplicationController
  layout 'admin/application'
  protect_from_forgery


  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "新規ジャンル　登録完了"
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render "index"
    end
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンル編集完了"
      redirect_to admin_igenre_path
    else
      render "edit"
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
