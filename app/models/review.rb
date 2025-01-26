class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hut
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true
  validate :images_limit

  #退会したuserのレビューを非表示にするための記述
  scope :active_users, -> { joins(:user).where(users: { is_active: true })}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  private

  def images_limit
    if images.attached? && images.count > 4
      errors.add(:base, "You can upload up to 4 images")
    end
  end
end
