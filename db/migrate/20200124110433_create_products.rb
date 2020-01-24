class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'

    create_table :products, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :title
      t.string :description
      t.string :country
      t.string :tags, array: true, default: []
      t.decimal :price, precision: 12, scale: 4

      t.timestamps
    end

    add_index :products, :title
    add_index :products, :country
  end
end
