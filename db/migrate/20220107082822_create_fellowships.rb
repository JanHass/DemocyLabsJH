class CreateFellowships < ActiveRecord::Migration[5.2]
  def change
    create_table :fellowships do |t|
      t.string :name, null:false, unique:true
      t.text :fellowship_description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :organization_id
      t.integer :community_id
      t.integer :author_id
      t.integer :responsible_id
      t.integer :flags_count
      t.integer :geozone_id
      t.integer :postalcode_id
      t.boolean :clear_name, default:false
      t.boolean :easy_auth, default:false
      t.string :easy_auth_code
      t.boolean :complex_auth, default:false
      t.string :complex_auth_code

      t.timestamps
    end
    add_index :fellowships, :name, unique:true
    add_index :fellowships, :fellowship_description
    add_index :fellowships, :geozone_id
  end

end
