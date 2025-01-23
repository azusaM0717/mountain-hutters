class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    @message = notification.notification_message
    case notification.notifiable_type
    when "Comment"
      redirect_to review_path(notification.notifiable.review)
    else
      redirect_to review_path(notification.notifiable.review)
    end
  end
end