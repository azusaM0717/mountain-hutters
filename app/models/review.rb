class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hut
  has_many :favorites
  has_many :comments
  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true
  validate :image_count_within_limit

  private

  def image_count_within_limit
    if images.count > 4
      errors.add(:images, "は4枚以内にしてください。")
    end
  end
end
