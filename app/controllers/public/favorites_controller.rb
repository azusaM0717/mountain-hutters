class Public::FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(review_id: params[:review_id])
    redirect_to reviews_path, notice: "レビューにいいねしました！"
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    redirect_to reviews_path, notice: "レビューのいいねを取り消しました。"
  end
end
