module Searchable
  extend ActiveSupport::Concern

  class_methods do
    # Typecast columns to text. (In textacular repo, not yet packaged into version release.)
    # @TODO, Remove after textacular > 5.1.0
    def fuzzy_similarity_string(table_name, column, search_term)
      "COALESCE(similarity(#{table_name}.#{column}::text, #{search_term}), 0)"
    end

    def fuzzy_condition_string(table_name, column, search_term)
      "(#{table_name}.#{column}::text % #{search_term})"
    end

    # Searches through the model's String columns using PostgreSQL trigram search functionality
    # Depends on pg_trgm (http://www.postgresql.org/docs/9.1/static/pgtrgm.html)
    #
    # @param term [String] Optional search term
    # @param similarity [Float] Optional similarity threshold, defaults to 0.3
    # @return [ActiveRecord::Relation]
    def search(term = nil, similarity = 0.3)
      search_term = term.try(:strip)
      if search_term.present?
        ActiveRecord::Base.connection.execute("SELECT set_limit(#{similarity});") if similarity.present?
        fuzzy_search(search_term)
      else
        default_scoped
      end
    end

    # @param term [String] Optional search term
    # @param cols [String] Optional columns to search
    # @param similarity [Float] Optional similarity threshold, defaults to 0.3
    # @return [ActiveRecord::Relation]
    def search_only(term = nil, cols = [], similarity = 0.3)
      search_term = term.try(:strip)
      if search_term.present? && !cols.empty?
        ActiveRecord::Base.connection.execute("SELECT set_limit(#{similarity});") if similarity.present?
        query = if cols.is_a?(Hash)
          cols.each do |table_name, table_cols|
            cols[table_name] = table_cols.map { |c| [c, search_term] }.to_h
          end
        else
          cols.map { |c| [c, search_term] }.to_h
        end
        fuzzy_search(query, false)
      else
        default_scoped
      end
    end
  end
end
