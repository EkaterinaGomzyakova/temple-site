class CreateNews < ActiveRecord::Migration[7.2]
  def change
    create_table :news do |t|
      t.string :title, null: false
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :slug
      t.integer :position
      t.boolean :is_published, default: false
      t.timestamps
    end
  end
end