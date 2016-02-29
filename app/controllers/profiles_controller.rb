class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if user_params[:password].empty?
      if @user.update(user_params)
        sign_in @user, bypass: true
        flash[:notice] = "Профиль был успешно обновлен"
        redirect_to :back
      else
        flash[:alert] = @user.errors.full_messages.join('. ')
        redirect_to :back
      end
    else
      if @user.update_without_password(user_params)
        flash[:notice] = "Профиль был успешно обновлен"
        redirect_to :back
      else
        flash[:alert] = @user.errors.full_messages.join('. ')
        redirect_to :back
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :organization, :phone_number, :password, :password_confirmation)
  end
end
