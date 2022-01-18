class AddPostalCodeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postal_code, :string
  end
end
