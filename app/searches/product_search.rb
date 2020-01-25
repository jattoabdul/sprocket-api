class ProductSearch < Search
  private def search_class
    Product
  end

  private def where
    where = {}
    if options[:country].present?
      where[:country] = options.delete(:country)
    end

    if options[:price].present?
      price_range = options.delete(:price).split(',').map(&:to_f)
      # where[:price] = price_range[0]..price_range[1]
      where[:price] = {gte: price_range[0], lte: price_range[1]}
    end

    where
  end
end
