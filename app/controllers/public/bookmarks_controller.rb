class Public::BookmarksController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    @bookmark = @post.bookmarks.create(user: current_user)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referrer }
    end
  end

  def destroy
    @bookmark = @post.bookmarks.find_by(user: current_user)
    @bookmark.destroy if @bookmark
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referrer }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
