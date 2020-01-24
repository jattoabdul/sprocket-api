class Product < ApplicationRecord
  include Searchable
  include SerializableResource

  # searchkick
  searchkick text_middle: %i(title description country price), callbacks: :async
  
  def search_data
    {
      title: title,
      description: description,
      country: country,
      price: price,
      tags: tags
    }
  end
end
