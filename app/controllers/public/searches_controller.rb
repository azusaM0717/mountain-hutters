class Public::SearchesController < ApplicationController
  def index
    @huts = Hut.all

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
  end
end
