class Admin::HutsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @hut = Hut.new
  end

  def index
    @hut = Hut.all
  end

  def create
    @hut = Hut.new(hut_params)
    if @hut.save
      redirect_to admin_hut_path(@hut)
    else
      render :new
    end
  end

  def show
    @hut = Hut.find(params[:id])
  end

  def edit
    @hut = Hut.find(params[:id])
  end

  def update
    @hut = Hut.find(params[:id])
    if @hut.update(hut_params)
      redirect_to admin_hut_path(@hut), notice:"変更が保存されました"
    else
      render :edit
    end
  end

  private

  def hut_params
    params.require(:hut).permit(:name, :latitude, :longitude, :description)
  end
end
