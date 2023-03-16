class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  include SearchMethod

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  def search
    @items = Item.all
    search_term = params[:search]
    search_method(search_term)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :category, :designed_by, :search)
    end
end
