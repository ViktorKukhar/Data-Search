module SearchMethod
  def search_method(search_term)
    # Support for negative searches, e.g. john -array
      excluded_terms = search_term.scan(/-(\w+)/).flatten
      @json_data.reject! do |item|
        excluded_terms.any? do |term|
          item['Name'].downcase.include?(term) || item['Type'].downcase.include?(term) || item['Designed by'].downcase.include?(term)
        end
      end

      # Remove excluded terms from original query
      search_term = search_term.gsub(/-\w+/, '').strip

      # Match in different fields, e.g. Scripting Microsoft
      # should return all scripting languages designed by "Microsoft"
      query_terms = search_term.split
      @json_data.select! do |item|
        query_terms.all? do |term|
          item['Name'].downcase.include?(term) || item['Type'].downcase.include?(term) || item['Designed by'].downcase.include?(term)
        end
      end

      # Search match precision
      @json_data.sort_by! do |item|
        case item
        when ->(i) { i['Name'].downcase.start_with?(search_term) }
          1
        when ->(i) { i['Type'].downcase.start_with?(search_term) }
          2
        when ->(i) { i['Designed by'].downcase.start_with?(search_term) }
          3
        else
          4
        end
      end

      @json_data

    end
end
