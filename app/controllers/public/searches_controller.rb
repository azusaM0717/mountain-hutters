class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @huts = Hut.all
  
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
  
    @huts = @huts.page(params[:page]).per(6)
  end
  
end
