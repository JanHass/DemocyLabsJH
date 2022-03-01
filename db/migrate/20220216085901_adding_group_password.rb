class AddingGroupPassword < ActiveRecord::Migration[5.2]
  def change
    add_column :fellowships, :join_password_required, :boolean, default: false
    add_column :fellowships, :join_password, :string
  end
end
