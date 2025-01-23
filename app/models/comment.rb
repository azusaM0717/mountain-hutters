class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :body, presence: true
end
