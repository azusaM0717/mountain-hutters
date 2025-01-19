class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    @huts = Hut.all
  end

  def index
    if params[:user_id]
      # user_idのパラメーターが渡されたときは特定のユーザーのレビューを表示
      @user = User.find(params[:user_id]) 
      @reviews = @user.reviews.includes(:hut).order(created_at: :desc).page(params[:page]).per(6)
    elsif params[:all_reviews]
      # すべてのレビューを表示するための条件分岐
      @user = nil
      @reviews = Review.includes(:hut, :user).order(created_at: :desc).page(params[:page]).per(6)
    else
      # ログイン中のユーザーのレビューを表示
      @user = current_user
      @reviews = current_user.reviews.includes(:hut).order(created_at: :desc).page(params[:page]).per(6)
    end
  end
  

  def show
    @review = Review.find(params[:id])
    @hut = @review.hut
    @comment = Comment.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to review_path(@review), notice: "レビューを投稿しました！"
    else
      @huts = Hut.all
      flash.now[:alert] = "レビューの作成に失敗しました。"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @huts = Hut.all
    unless @review.user == current_user
      redirect_to reviews_path, alert: "アクセス権限がありません。"
    end
  end

  def update
    @review = Review.find(params[:id])
    unless @review.user == current_user
      redirect_to reviews_path, alert: "アクセス権限がありません。"
      return
    end
    
    if @review.update(review_params)
      redirect_to review_path(@review), notice:"変更が保存されました"
    else
      flash.now[:alert] = "レビューの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to reviews_path, notice: "レビューが削除されました"
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating, :hut_id, images: [])
  end
end
