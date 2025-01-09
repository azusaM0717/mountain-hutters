class Public::CommentsController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    comment = review.comments.new(comment_params)
  end

  def destroy
    comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id)
  end
end

