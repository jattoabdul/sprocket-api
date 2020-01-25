class ProductsController < ApplicationController
  before_action :set_product, only: %i(show update destroy)

  # GET /products
  def index
    @products = Product.order(updated_at: :desc).
      limit([params[:limit] && params[:limit].to_i || 100].compact.min).
      offset([params[:offset] && params[:offset].to_i || 0].compact.min)

    render resource: @products
  end

  # GET /products/search
  def search
    # Don't hit database with less than 2 chars
    return render json: [] if params[:query].present? && params[:query].strip.size <= 1

      options = {
        fields: ['title^5',  'country^4',  'description^3', {tags: :exact}, 'price^2'],
        operator: 'or',
        match: :text_middle,
        limit: [params[:limit] && params[:limit].to_i || 100].compact.min,
        offset: [params[:offset] && params[:offset].to_i || 0].compact.min,
        misspellings: { edit_distance: 2, below: 1, fields: %i(title) }
      }.merge(search_params)

    # cache_key = "products:#{params.fetch(:query, 'default')}#{options.fetch(:limit, '100')}#{options.fetch(:offset, '0')}#{options.fetch(:page, '')}#{options.fetch(:per_page, '')}"
    # @products =  Rails.cache.fetch(cache_key) do
    #   ProductSearch.new(query: params[:query], options: options)
    #     .search
    # end

    @products =  ProductSearch.new(query: params[:query], options: options)
      .search

    render resource: @products
  rescue Searchkick::Error, StandardError => e
    render json: []
  end

  # POST /products
  def create
    @product = Product.create(product_params)
    render resource: @product, status: 201
  end

  # GET /products/1
  def show
    render resource: @product
  end

  # PATCH /products/1
  def update
    @product.update(product_params)
    render resource: @product
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    head 204
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :tags)
  end

  def search_params
    params.permit :page, :per_page, :sort_attribute, :sort_order, :country, :offset, :limit
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
