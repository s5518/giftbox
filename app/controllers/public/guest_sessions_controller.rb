class Public::GuestSessionsController < Devise::SessionsController
  def create
    user = User.guest
    sign_in(:user, user)
    redirect_to user_path(user), notice: "guestuserでログインしました。", status: :see_other
  end

  def new_registration
    if current_user&.guest_user?
      sign_out(:user)
      redirect_to new_user_registration_path
    else
      redirect_to user_path(current_user)
    end
  end
end
