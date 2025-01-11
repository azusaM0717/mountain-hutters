class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to mypage_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render :edit, alert: "ユーザー情報の更新に失敗しました。"
    end
  end

  def unsubscribe
    Rails.logger.debug "Unsubscribe action reached"
    # 退会確認ページの表示を行う
  end
  

  def withdraw
    @user = current_user
    if @user.update(is_active: false)
      reset_session
      redirect_to root_path, motice: "退会処理が完了しました。"
    else
      redirect_to mypage_path(@user), alert: "退会処理に失敗しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :is_active)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
