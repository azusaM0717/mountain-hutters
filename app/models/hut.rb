class Hut < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :calendars

  validates :name, presence: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :description, presence: true

  # 山小屋情報一覧と山小屋情報詳細にレビューの平均評価を表示するため
  def average_rating
    if reviews.any?
      reviews.average(:rating).to_f.round(1)
    else
      "まだ評価がありません。"
    end
  end
end
