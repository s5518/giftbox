class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [ :edit, :update, :destroy ]
  before_action :ensure_not_guest_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.where.not(email: User::GUEST_USER_EMAIL)
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil? || (@user.guest_user? && @user != current_user)
      redirect_to users_path, alert: "このユーザーの詳細は表示できません。"
      return
    end

    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
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

  def ensure_not_guest_user
    if current_user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはこの操作を行えません。", status: :see_other
    end

  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
