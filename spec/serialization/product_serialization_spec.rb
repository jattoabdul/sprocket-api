require 'rails_helper'

RSpec.describe SerializableProduct, type: :serializer do
  describe 'Data Validation' do
    context 'Product' do
      let(:product) { create(:product) }
      let(:product_serializable) { product.serialize }

      it 'has an id that matches' do
        expect(product_serializable[:id]).to eql(product.id)
      end

      it 'has attributes that matches' do
        expect(product_serializable[:title]).to eql(product.title)
        expect(product_serializable[:description]).to eql(product.description)
        expect(product_serializable[:country]).to eql(product.country)
        expect(product_serializable[:price]).to eql(product.price)
      end
    end
  end
end
