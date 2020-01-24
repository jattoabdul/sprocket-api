class SerializableProduct < JSONAPI::Serializable::Resource
  type :product
  attribute(:id) { @object.id }
  attributes :title, :description, :price, :tags

  attribute(:created_at) { @object.created_at&.utc }
  attribute(:updated_at) { @object.updated_at&.utc }
end
