module SearchMethod
  def search_method(search_term)

    # Support for negative searches, e.g. john -array
    excluded_terms = search_term.scan(/-(\w+)/).flatten
    excluded_terms.each do |term|
      @items = @items.where.not("name ILIKE ? OR category ILIKE ? OR designed_by ILIKE ?", "%#{term}%", "%#{term}%", "%#{term}%")
    end

    # Remove excluded terms from original query
    search_term = search_term.gsub(/-\w+/, '').strip

    # Match in different fields, e.g. Scripting Microsoft
    # should return all scripting languages designed by "Microsoft"
    query_terms = search_term.split
    query_terms.each do |term|
      @items = @items.where("name ILIKE ? OR category ILIKE ? OR designed_by ILIKE ?", "%#{term}%", "%#{term}%", "%#{term}%")
    end

     # Search match precision
     @items = @items.order(Arel.sql("CASE
                                      WHEN name ILIKE '#{search_term}%' THEN 1
                                      WHEN category ILIKE '#{search_term}%' THEN 2
                                      WHEN designed_by ILIKE '#{search_term}%' THEN 3
                                      ELSE 4
                                    END"))

    end
end
