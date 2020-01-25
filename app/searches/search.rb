class Search
  attr_reader :query, :options

  def initialize(query:, options: {})
    @query = query.presence || "*"
    @options = options
  end

  def search
    options[:where] = where
    options[:order] = order

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
      order_options = {}
      order_attr_value = options[:sort_order].presence.to_sym || :desc
      if options[:sort_attribute] == 'relevance'
        order_options[:_score] = order_attr_value
      elsif options[:sort_attribute] == 'newest'
        order_options[:updated_at] = order_attr_value
      else
        order_options[options[:sort_attribute] .to_sym] = order_attr_value
      end

      options.delete(:sort_attribute)
      options.delete(:sort_order)
      order_options
    else
     {}
    end
  end
end
