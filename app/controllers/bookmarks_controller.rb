class BookmarksController < ApplicationController
  before_action :set_list, only: %i[new create]
  before_action :set_bookmark, only: [:destroy]

  def new
    @bookmark = @list ? @list.bookmarks.new : Bookmark.new
    @movies = Movie.all
  end

  def create
    @bookmark = @list.bookmarks.new(bookmark_params)
    if @bookmark.save
      redirect_to @bookmark.list
    else
      @movies = Movie.all
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to @bookmark.list
  end

  private

  def set_list
    @list = List.find(params[:list_id]) if params[:list_id]
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
