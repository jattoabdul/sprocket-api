class Search
  attr_reader :query, :options

  def initialize(query:, options: {})
    @query = query.presence || "*"
    @options = options
  end

  def search
    options[:where] = where
    options[:order] = order

    puts('got search  option here', options)
    search_class.search(query, options)
  end

  private def search_class
    raise NotImplementedError
  end

  private def where
    {}
  end

  private def order
    if options[:sort_attribute].present?
      order = options[:sort_order].presence || :asc
      { options[:sort_attribute] => order }
    else
     {}
    end
  end
end
