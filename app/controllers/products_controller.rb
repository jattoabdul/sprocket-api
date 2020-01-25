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
    query = search_params.delete(:query)
    return render json: [] if query.present? && query.strip.size <= 1

    options = {
      fields: ['title^6',  'country^3',  'description', {tags: :exact}, 'price^2'],
      operator: 'or',
      match: :text_middle,
      limit: [params[:limit] && params[:limit].to_i || 100].compact.min,
      offset: [params[:offset] && params[:offset].to_i || 0].compact.min,
      misspellings: { edit_distance: 2, below: 1, fields: %i(title) }
    }.merge(search_params.except(:query)).deep_symbolize_keys!

    cache_key = "products:#{query || 'default'}#{options.fetch(:limit, '100')} \
    #{options.fetch(:offset, '0')}#{options.fetch(:country, '')} \
    #{options.fetch(:price, '')}#{options.fetch(:sort_order, '')} \
    #{options.fetch(:sort_attribute, '')}"
    @products =  Rails.cache.fetch(cache_key) do
      ProductSearch.new(query: query, options: options)
        .search
    end

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
    params.permit(:query, :sort_attribute, :sort_order, :country, :price, :offset, :limit)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
