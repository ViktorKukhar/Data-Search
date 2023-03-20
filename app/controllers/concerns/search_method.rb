module SearchMethod

  def search_method(search_term)
     exclude_data_with_terms(search_term)
     query_data_with_terms(search_term)
     sort_data_by_match_precision(search_term)
     @json_data
   end

   private

   def exclude_data_with_terms(search_term)
     excluded_terms = search_term.scan(/-(\w+)/).flatten
     excluded_terms.each do |term|
       @json_data.reject! do |data|
         data['Name'].downcase.include?(term) || data['Type'].downcase.include?(term) || data['Designed by'].downcase.include?(term)
       end
     end
   end

   def query_data_with_terms(search_term)
     query_terms = search_term.gsub(/-\w+/, '').strip.split
     query_terms.each do |term|
       @json_data.select! do |data|
         data['Name'].downcase.include?(term) || data['Type'].downcase.include?(term) || data['Designed by'].downcase.include?(term)
       end
     end
   end

   def sort_data_by_match_precision(search_term)
     @json_data.sort_by! do |data|
       case data
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
   end
end
