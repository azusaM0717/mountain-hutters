class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @huts = Hut.all
  end

  def index
    @reviews = Review.includes(:user, :hut).all
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to review_path(@review), notice: "レビューを投稿しました！"
    else
      @huts = Hut.all
      render :new, alert: "投稿に失敗しました。"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @huts = Hut.all
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path(@review), notice:"変更が保存されました"
    else
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to mypage_path, notice: "レビューが削除されました"
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating, :hut_id, images: []).merge(rating: params[:review][:rating] || 1)
    # rating実装後に.merge以降の記述を削除する。ひとまずデータとして1が送られるようにする。
  end
end
