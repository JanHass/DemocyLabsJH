class AddingOwnerAndShortDecsription < ActiveRecord::Migration[5.2]
  def change
    add_column :fellowship_users, :is_fellowship_owner, :boolean, default: false
    add_column :fellowships, :short_description, :string
  end
end
