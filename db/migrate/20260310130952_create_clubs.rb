class CreateClubs < ActiveRecord::Migration[7.2]
  def change
    create_table :clubs do |t|
      t.string :name, null: false
      t.text :description
      t.references :admin_user, null: false, foreign_key: { to_table: :users }
      t.string :slug
      t.integer :position
      t.timestamps
    end
  end
end