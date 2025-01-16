class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    review = Review.find(params[:review_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.review_id = review.id
    if comment.save
      redirect_to review_path(review), notice: "コメントが投稿されました。"
    else
      redirect_to review_path(review), alert: "コメントの投稿に失敗しました。"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to review_path(params[:review_id]), notice: "コメントが削除されました"
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end

