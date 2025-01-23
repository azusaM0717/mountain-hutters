class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def notification_message
    case notifiable_type
    when "Comment"
      "投稿した#{notifiable.review.title}に#{notifiable.user.name}さんがコメントしました。"
    else
      "投稿した#{notifiable.review.title}が#{notifiable.user.name}さんにいいねされました。"
    end
  end
end
