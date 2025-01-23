class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hut
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true
  validate :images_limit
  

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  private

  def images_limit
    if images.attached? && images.count > 4
      errors.add(:base, "You can upload up to 4 images")
      Rails.logger.debug "Validation Error Added: #{errors.full_messages}"
    end
  end
end
