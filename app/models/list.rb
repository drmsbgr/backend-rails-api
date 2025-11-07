class List < ApplicationRecord
  belongs_to :board
  has_many :cards, dependent: :destroy 
  # Bir liste silinirse, altındaki tüm kartlar da silinsin.

  validates :title, presence: true
end