class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @review = Review.find(params[:review_id])
    @favorite = current_user.favorites.new(review_id: review.id)
    favorite.save
    redirect_to review_path(review), notice: "レビューにいいねしました！"
  end

  def destroy
    review = Review.find(params[:review_id])
    @favorite = current_user.favorites.find_by(review_id: review/id)
    favorite.destroy
    redirect_to review_path(review), notice: "レビューのいいねを取り消しました。"
  end
end
