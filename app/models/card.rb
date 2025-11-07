class Card < ApplicationRecord
  belongs_to :list

  validates :content, presence: true

  # YENİ EKLENDİ: Kartları her zaman position'a göre artan sırada getir.
  default_scope { order(position: :asc) }
end