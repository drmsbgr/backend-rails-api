class BoardSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at

  # Board'u çekince, listeleri de çek
  has_many :lists
end