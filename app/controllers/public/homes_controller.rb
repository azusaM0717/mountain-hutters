class Public::HomesController < ApplicationController
  def top
    @reviews = Review.includes(:user, :hut).order(created_at: :desc).limit(3)
  end

  def about
  end
end
