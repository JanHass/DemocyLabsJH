class CreateFellowships < ActiveRecord::Migration[5.2]
  def change
    create_table :fellowships do |t|
      t.string :name
      t.string :email
      t.text :description
      t.datetime :created_at
      t.datetime :updatet_at
      t.integer :organization_id
      t.integer :user_id
      t.integer :author_id
      t.integer :responsible_id
      t.integer :flags_count
      t.integer :geozone_id
      t.integer :community_id
      t.boolean :clear_name
      t.boolean :user_required_full_name
      t.boolean :user_required_phone_number
      t.boolean :user_required_gender
      t.boolean :user_required_date_of_birth
      t.boolean :user_required_adress
      t.boolean :user_required_state
      t.boolean :user_required_city
      t.boolean :user_required_country
      t.boolean :user_public_show_full_name
      t.boolean :user_public_show_phone_number
      t.boolean :user_public_show_gender
      t.boolean :user_public_show_date_of_birth
      t.boolean :user_public_show_address
      t.boolean :user_public_show_state
      t.boolean :user_public_show_city
      t.boolean :user_public_show_country
      t.boolean :admin_required_full_name
      t.boolean :admin_required_phone_number
      t.boolean :admin_required_gender
      t.boolean :admin_required_date_of_birth
      t.boolean :admin_required_address
      t.boolean :admin_required_state
      t.boolean :admin_required_city
      t.boolean :admin_required_country
      t.boolean :admin_public_show_full_name
      t.boolean :admin_public_show_phone_number
      t.boolean :admin_public_show_gender
      t.boolean :admin_public_show_date_of_birth
      t.boolean :admin_public_show_address
      t.boolean :admin_public_show_state
      t.boolean :admin_public_show_city
      t.boolean :admin_public_show_country

      t.timestamps
    end
    add_index :fellowships, :name
    add_index :fellowships, :email
    add_index :fellowships, :author_id
  end
end
