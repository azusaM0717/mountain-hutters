class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_review_comments_path(comment.review), notice: "コメントが削除されました"
  end
end
