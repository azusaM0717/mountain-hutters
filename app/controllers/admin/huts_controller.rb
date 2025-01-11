class Admin::HutsController < ApplicationController
  def new
    @hut = Hut.new
  end

  def index
    @hut = Hut.all
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end
end
