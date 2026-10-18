class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [ :create, :destroy ]

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@post) }
      end
    else
      redirect_to post_path(@post), alert: "コメントを投稿できませんでした"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to post_path(@post) }
    end
  end

  private

  def ensure_guest_user
    if current_user.guest_user?
      redirect_to posts_path, alert: "ゲストユーザーはこの操作を行えません。", status: :see_other
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
