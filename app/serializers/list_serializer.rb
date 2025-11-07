class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :board_id

  # Listeyi çekince, kartları da çek
  has_many :cards
end