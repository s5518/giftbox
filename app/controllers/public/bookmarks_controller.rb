class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :create, :destroy ]
  before_action :ensure_guest_user, only: [ :create, :destroy ]
  before_action :ensure_not_own_post, only: [:create]

  def index
    @posts = current_user.bookmarked_posts
  end

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

  def ensure_not_own_post
    if @post.user_id == current_user.id
      redirect_to post_path(@post), alert: "自分の投稿はブックマークできません。", status: :see_other
    end
  end

  def ensure_guest_user
    if current_user.guest_user?
      redirect_to posts_path, alert: "ゲストユーザーはこの操作を行えません。", status: :see_other
    end
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
