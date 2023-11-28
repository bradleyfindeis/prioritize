class ListItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :votes_count
end