class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :review_id}
end
