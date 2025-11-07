class Board < ApplicationRecord
  has_many :lists, dependent: :destroy
  # Bir pano silinirse, altındaki tüm listeler de silinsin.

  validates :name, presence: true # Boş pano ismi olmasın
end