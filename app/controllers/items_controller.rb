class ItemsController < ApplicationController
  before_action :set_json, only: %i[ index search ]
  include SearchMethod

  def search
    search_term = params[:search].downcase
    search_method(search_term)
  end

  private

    def set_json
      json_file = File.read(Rails.root.join('db', 'data.json'))
      @json_data = JSON.parse(json_file)
    end

end
