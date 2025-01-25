class Comment < ApplicationRecord
  after_create do
    create_notification(user_id: review.user_id)
  end
  
  belongs_to :user
  belongs_to :review
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 200 }
  
  #退会したuserのコメントを非表示にするための記述
  scope :active_users, -> { joins(:user).where(users: { is_active: true }) }
end
