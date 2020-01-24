ActiveRecord::Base.transaction do
  products = YAML.load(File.read(File.join(__dir__, '..', 'fixtures', 'products.yml'))).map(&:deep_symbolize_keys)

  products.each do |product|
    Product.find_or_initialize_by(title: product[:title], country: product[:country]).
      tap { |model| model.assign_attributes(product) }.
      save!
  end
end
