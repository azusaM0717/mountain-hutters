class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @reviews = Review.includes(:hut, :user).order(created_at: :desc)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path, notice: "レビューを削除しました。"
  end
end
