class Product < ApplicationRecord
  include Searchable
  include SerializableResource

  # searchkick
  searchkick text_middle: %i(title description country price), callbacks: :async

  after_commit :flush_cache!
  
  def search_data
    {
      title: title,
      description: description,
      country: country,
      price: price.to_f,
      tags: tags,
      updated_at: updated_at
    }
  end

  private

  def flush_cache!
    # Clear products:* caches
    Rails.cache.delete_matched 'products:*'
  end
end
