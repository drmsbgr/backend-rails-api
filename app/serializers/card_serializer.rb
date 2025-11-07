class CardSerializer < ActiveModel::Serializer
  attributes :id, :content, :list_id,:position
end