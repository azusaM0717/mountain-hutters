class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hut
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true
  validate :image_count_within_limit
  

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  private

  def image_count_within_limit
    if images.count > 4
      errors.add(:images, "は4枚以内にしてください。")
    end
  end
end
