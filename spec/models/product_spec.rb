require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Factories' do
    context 'Valid factory' do
      subject { create(:product) }
      specify { should be_valid }
    end

    context 'Invalid factory' do
      subject { build(:invalid_product) }
      specify { is_expected.not_to be_valid }
    end
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
  end

  describe 'Callbacks' do
    describe 'after_commit' do
      let(:product) { create(:product) }

      it 'should call flush_cache!' do
        expect_any_instance_of(Product).to receive(:flush_cache!).twice # create & touch
        product.touch
      end
    end
  end

  describe "Instance Method" do
    unless ENV.key?('IS_CONTINUOUS_INTEGRATION')
      describe '#search Product', search: true do
        let(:product) { create(:product, :reindex, title: 'Sprocket') }
  
        it 'searches' do
          Product.search_index.refresh
          expect([product.title]).to eq Product.search('Sprocket').map(&:title)
        end
      end
    end
  end
end
