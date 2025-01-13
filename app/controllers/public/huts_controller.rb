class Public::HutsController < ApplicationController
  def index
    @huts = Hut.includes(:reviews)
  end

  def show
    @hut = Hut.find(params[:id])
  end
end
