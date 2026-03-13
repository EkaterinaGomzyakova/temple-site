class CreateProductCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :product_categories do |t|
      t.string :name, null: false
      t.integer :position
      t.timestamps
    end
  end
end