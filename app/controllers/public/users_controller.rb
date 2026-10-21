class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [ :edit, :update, :destroy ]
  before_action :ensure_guest_user, only: [ :edit, :update ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    if current_user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはこの操作を行えません。", status: :see_other
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
