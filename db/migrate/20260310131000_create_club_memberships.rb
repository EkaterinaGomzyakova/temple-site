class CreateClubMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :club_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :club, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end