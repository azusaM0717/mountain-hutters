class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    case params[:search_type]
    when "huts"
      @huts = Hut.all

      # キーワード検索
      if params[:keyword].present?
        @huts = @huts.where("name LIKE ?", "%#{params[:keyword]}%")
      end

      # 並び順検索
      case params[:sort]
      when 'rating_desc'
        @huts = @huts.joins(:reviews).select("huts.*, AVG(reviews.rating) AS average_rating")
                     .group("huts.id")
                     .order("average_rating DESC")
      when 'review_count_desc'
        @huts = @huts.joins(:reviews).select("huts.*, COUNT(reviews.id) AS review_count")
                     .group("huts.id")
                     .order("review_count DESC")
      when 'newest'
        @huts = @huts.joins(:reviews).select("huts.*, MAX(reviews.created_at) AS latest_review")
                     .group("huts.id")
                     .order("latest_review DESC")
      end

    when "reviews"
      @reviews = Review.active_users

      # キーワード検索
      if params[:keyword].present?
        @reviews = @reviews.where("body LIKE ?", "%#{params[:keyword]}%")
      end

      # 日付範囲検索
      if params[:start_date].present? && params[:end_date].present?
        if params[:start_date] > params[:end_date]
          flash.now[:alert] = "開始日は終了日より前の日付を選択してください"
          return
        end
        @reviews = @reviews.where(created_at: params[:start_date].to_date.beginning_of_day..params[:end_date].to_date.end_of_day)
      elsif params[:start_date].present?
        @reviews = @reviews.where("created_at >= ?", params[:start_date].to_date.beginning_of_day)
      elsif params[:end_date].present?
        @reviews = @reviews.where("created_at <= ?", params[:end_date].to_date.end_of_day)
      end
      

      # 並び順検索
      case params[:sort]
      when 'newest'
        @reviews = @reviews.order("created_at DESC")
      when 'favorites_desc'
        @reviews = @reviews.left_joins(:favorites)
                           .group("reviews.id")
                           .order("COUNT(favorites.id) DESC, reviews.created_at DESC")
      end
    end

    @huts = @huts.page(params[:page]).per(6) if @huts
    @reviews = @reviews.page(params[:page]).per(6) if @reviews
  end
end
