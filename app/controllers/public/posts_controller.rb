class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [ :edit, :update, :destroy ]
  before_action :ensure_guest_user, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    if params[:star_count]
      @posts = Post.all.order(rating: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      @tags = Tag.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tags = Tag.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      @tags = Tag.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end

  def ensure_guest_user
    if current_user.guest_user?
      redirect_to posts_path, alert: "ゲストユーザーはこの操作を行えません。"
    end
  end

  def post_params
    params.require(:post).permit(:gift_name, :content, :rating, :age, :price, :image, tag_ids: [])
  end
end
