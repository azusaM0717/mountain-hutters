class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.page(params[:page]).per(10)
  end

  def destroy
  end
end
