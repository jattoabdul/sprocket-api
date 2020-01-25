require 'rails_helper'

def json(response)
  JSON.parse(response.body, symbolize_names: true)
end

RSpec.describe ProductsController, type: :controller do
  describe 'GET index' do
    let!(:count) { Product.all.count }
    let!(:product) { create(:product, title: 'Sprocket') }

      it 'returns product array' do
        get :index, format: :json
        expect(json(response).size).to eq(count + 1)
        expect(json(response).first[:title]).to eq('Sprocket')
      end
  end

  unless ENV.key?('IS_CONTINUOUS_INTEGRATION')
    describe 'GET search' do
      let!(:product) { create(:product, :reindex) }
      let(:title) { product.title }
      let(:country) { product.country }

      it 'returns products array with min query size' do
        get :search, params: { query: title.slice(-4, 4).to_s }, format: :json
        expect(json(response).size).to be >= 1
        expect(json(response).map { |v| v[:title] }).to include(title)
      end

      it 'returns empty array with less than min query size' do
        get :search, params: { query: '2' }, format: :json
        expect(json(response)).to eq([])
      end

      context "when filtering by country" do
        it "should return only products for that country" do
          get :search, params: { query: title.slice(-4, 4).to_s, country: country }, format: :json
          expect(json(response).size).to eql(1)
          expect(json(response).map { |v| v[:country] }).to include(country)
        end
        
        it "should not return product for another country" do
          get :search, params: { query: title.slice(-4, 4).to_s, country: country }, format: :json
          expect(json(response).size).to eql(1)
          expect(json(response).map { |v| v[:country] }).not_to include('Canada')
        end
      end
    end
  end
end
