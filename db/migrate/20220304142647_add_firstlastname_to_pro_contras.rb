class AddFirstlastnameToProContras < ActiveRecord::Migration[5.2]
  def change
    add_column :pro_contras, :user_first_name, :string
    add_column :pro_contras, :user_last_name, :string
    add_column :objections, :user_first_name, :string
    add_column :objections, :user_last_name, :string
  end
end
