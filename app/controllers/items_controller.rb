class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  def search
    search_term = params[:search]
    @items = Item.all

    # Support for negative searches, e.g. john -array
    excluded_terms = search_term.scan(/-(\w+)/).flatten
    excluded_terms.each do |term|
      @items = @items.where.not("name LIKE ? OR category LIKE ? OR designed_by LIKE ?", "%#{term}%", "%#{term}%", "%#{term}%")
    end

    # Remove excluded terms from original query
    search_term = search_term.gsub(/-\w+/, '').strip

    # Match in different fields, e.g. Scripting Microsoft
    # should return all scripting languages designed by "Microsoft"
    query_terms = search_term.split
    query_terms.each do |term|
      @items = @items.where("name LIKE ? OR category LIKE ? OR designed_by LIKE ?", "%#{term}%", "%#{term}%", "%#{term}%")
    end

     # Search match precision
     @items = @items.order(Arel.sql("CASE
                                      WHEN name LIKE '#{search_term}%' THEN 1
                                      WHEN category LIKE '#{search_term}%' THEN 2
                                      WHEN designed_by LIKE '#{search_term}%' THEN 3
                                      ELSE 4
                                    END"))

    end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
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
