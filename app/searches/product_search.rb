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
      price_start, price_end = options.delete(:price).split(',').map(&:to_f)
      # where[:price] = price_start..price_end
      where[:price] = { gte: price_start, lte: price_end }
    end

    where
  end
end
