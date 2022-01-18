class AddZipCode < ActiveRecord::Migration[5.2]
  def change
    add_column :fellowships, :zip_code, :integer
  end
end
