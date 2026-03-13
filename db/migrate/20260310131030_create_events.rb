class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.string :location
      t.decimal :price
      t.integer :capacity
      t.boolean :has_registration, default: false
      t.string :external_registration_url
      t.integer :event_type, null: false
      t.references :club, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :slug
      t.boolean :is_published, default: false
      t.datetime :archived_at
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :events, :start_time
  end
end