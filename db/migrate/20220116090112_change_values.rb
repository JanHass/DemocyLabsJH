class ChangeValues < ActiveRecord::Migration[5.2]
  def change
    change_column :fellowships, :user_required_phone_number, :boolean, default: false
    change_column :fellowships, :user_required_gender, :boolean, default: false
    change_column :fellowships, :user_required_date_of_birth, :boolean, default: false
    change_column :fellowships, :user_required_adress, :boolean, default: false
    change_column :fellowships, :user_required_state, :boolean, default: false
    change_column :fellowships, :user_required_city, :boolean, default: false
    change_column :fellowships, :user_required_country, :boolean, default: false
    change_column :fellowships, :user_public_show_full_name, :boolean, default: false
    change_column :fellowships, :user_public_show_phone_number, :boolean, default: false
    change_column :fellowships, :user_public_show_gender, :boolean, default: false
    change_column :fellowships, :user_public_show_date_of_birth, :boolean, default: false
    change_column :fellowships, :user_public_show_address, :boolean, default: false
    change_column :fellowships, :user_public_show_state, :boolean, default: false
    change_column :fellowships, :user_public_show_city, :boolean, default: false
    change_column :fellowships, :user_public_show_country, :boolean, default: false
    change_column :fellowships, :admin_required_full_name, :boolean, default: false
    change_column :fellowships, :admin_required_phone_number, :boolean, default: false
    change_column :fellowships, :admin_required_gender, :boolean, default: false
    change_column :fellowships, :admin_required_date_of_birth, :boolean, default: false
    change_column :fellowships, :admin_required_address, :boolean, default: false
    change_column :fellowships, :admin_required_state, :boolean, default: false
    change_column :fellowships, :admin_required_city, :boolean, default: false
    change_column :fellowships, :admin_required_country, :boolean, default: false
    change_column :fellowships, :admin_public_show_full_name, :boolean, default: false
    change_column :fellowships, :admin_public_show_phone_number, :boolean, default: false
    change_column :fellowships, :admin_public_show_gender, :boolean, default: false
    change_column :fellowships, :admin_public_show_date_of_birth, :boolean, default: false
    change_column :fellowships, :admin_public_show_address, :boolean, default: false
    change_column :fellowships, :admin_public_show_state, :boolean, default: false
    change_column :fellowships, :admin_public_show_city, :boolean, default: false
    change_column :fellowships, :admin_public_show_country, :boolean, default: false
  end
end
