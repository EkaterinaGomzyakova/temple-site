class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.decimal :total_price
      t.integer :delivery_type
      t.string :address
      t.string :phone
      t.text :comment
      t.timestamps
    end
  end
end