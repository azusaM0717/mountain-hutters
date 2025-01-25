class Public::HutsController < ApplicationController
  def index
    @huts = Hut.includes(:reviews).page(params[:page]).per(6)
  end

  def show
    @hut = Hut.find(params[:id])
    @reviews = @hut.reviews
                   .active_users
                   .includes(:user)
                   .order(created_at: :desc)
  end
end
