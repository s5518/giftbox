class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_not_guest_user, only: [ :show, :destroy ]

  def index
    @users = User.where.not(email: User::GUEST_USER_EMAIL).order(created_at: :desc)
  end

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end


  private

  def ensure_not_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to admin_users_path, alert: "ゲストユーザーにはアクセスできません。"
    end
  end
end
