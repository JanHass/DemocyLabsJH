class UserTogglePublicFields < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :public_profile_show_full_name, :bool, default: false
    add_column :users, :public_profile_show_phone_number, :bool, default: false
    add_column :users, :public_profile_show_gender, :bool, default: false
    add_column :users, :public_profile_show_date_of_birth, :bool, default: false
    add_column :users, :public_profile_show_address, :bool, default: false
    add_column :users, :public_profile_show_state, :bool, default: true
    add_column :users, :public_profile_show_city, :bool, default: true
    add_column :users, :public_profile_show_country, :bool, default: true
  end
end
