class Public::HomesController < ApplicationController
  def top
    @reviews = Review.active_users
                     .includes(:user, :hut)
                     .order(created_at: :desc)
                     .limit(3)
  end

  def about
  end
end
