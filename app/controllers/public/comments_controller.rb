class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

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

  def comment_params
    params.require(:comment).permit(:content)
  end
end
