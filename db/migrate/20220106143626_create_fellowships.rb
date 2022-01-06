class CreateFellowships < ActiveRecord::Migration[5.2]
  def change
    create_table :fellowships do |t|
      t.primary_key :id
      t.string :name
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :organization_id
      t.integer :author_id
      t.integer :responsible_id
      t.integer :flags_count
      t.integer :geozone_id
      t.integer :community_id
      t.boolean :clear_name

      t.timestamps
    end
    add_index :fellowships, :name
  end
end
