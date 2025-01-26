# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private
  def user_state
    user = User.find_by(email: params[:user][:email])
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])
    return if user.is_active == true
    if user.is_active == false
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_user_registration_path
    end
  end
end