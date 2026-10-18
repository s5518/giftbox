class Public::GuestSessionsController < Devise::SessionsController
  def create
    user = User.guest
    sign_in(:user, user)
    redirect_to user_path(user), notice: "guestuserでログインしました。", status: :see_other
  end
end
