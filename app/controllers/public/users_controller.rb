class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
    unless @user.id == current_user.id
      redirect_to mypage_path(current_user), alert: "アクセス権限がありません"
    end
  end

  def update
    @user = current_user
    unless @user.id == current_user.id
      redirect_to mypage_path(current_user), alert: "アクセス権限がありません"
      return
    end

    if @user.update(user_params)
      redirect_to "/mypage", notice: "ユーザー情報を更新しました"
    else
      render :edit, alert: "ユーザー情報の更新に失敗しました"
    end
  end

  def unsubscribe
    # 退会確認ページの表示を行う
  end
  

  def withdraw
    @user = current_user
    if @user.update(is_active: false)
      reset_session
      redirect_to root_path, motice: "退会処理が完了しました"
    else
      redirect_to mypage_path(@user), alert: "退会処理に失敗しました"
    end
  end

  # ユーザーがいいねしたレビュー一覧を表示
  def favorites
    @user = current_user
    @favorites = @user.favorites.includes(:review)
    @reviews = Review.active_users
                     .joins(:favorites)
                     .where(favorites: { user_id: @user.id })
                     .page(params[:page]).per(6)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :is_active)
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
