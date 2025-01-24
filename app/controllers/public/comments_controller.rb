class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @review = Review.find(params[:review_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.review_id = @review.id

    if @comment.save
      render "public/comments/create.js.erb"
    else
    # 失敗した場合はエラーメッセージを表示
      render "public/comments/errors.js.erb"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @review = @comment.review
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end

