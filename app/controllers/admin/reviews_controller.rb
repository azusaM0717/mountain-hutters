class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
  end

  def destroy
  end
end
