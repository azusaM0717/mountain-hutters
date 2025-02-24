class Calendar < ApplicationRecord
  belongs_to :user
  belongs_to :hut

  validates :hut, presence: true
end
