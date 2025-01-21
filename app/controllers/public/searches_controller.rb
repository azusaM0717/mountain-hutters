class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @huts = Hut.page(params[:page]).per(9)

    #キーワード検索
    if params[:keyword].present?
      @huts = @huts.where('name LIKE ?', "%#{params[:keyword]}%")
    end

    #評価の高い順
    if params[:sort] == 'rating_desc'
      @huts = @huts.order(rating: :desc)
    end

    #新しい投稿順
    if params[:sort] == 'newest'
      @huts = @huts.order(created_at: :desc)
    end

    #レビュー数の多い順
    if params[:sort] == 'review_count_desc'
      @huts = @huts.left_joins(:reviews).group(:id).order('COUNT(reviews.id) DESC')
    end
  end
end
