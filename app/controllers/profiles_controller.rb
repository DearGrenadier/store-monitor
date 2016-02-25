class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      sign_in @user, bypass: true
      flash[:notice] = "Профиль был успешно обновлен"
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :organization, :phone_number, :password, :password_confirmtion).reject{|_, v| v.blank?}
  end
end
