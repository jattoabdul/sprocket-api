class ProductSearch < Search
  private def search_class
    Product
  end

  private def where
    where = {}
    if options[:country].present?
      where[:country] = options[:country]
    end

    # if options[:high_price].present?
    #   where[:price] = { lte: options[:price] }
    # end

    where
  end
end
