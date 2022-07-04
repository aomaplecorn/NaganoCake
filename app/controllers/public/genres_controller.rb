class Public::GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @genres = @genre.items.page(params[:page]).per(8)
  end


end
