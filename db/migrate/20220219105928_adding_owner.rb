class AddingOwner < ActiveRecord::Migration[5.2]
  def change
    add_column :fellowships, :owner_id, :integer
  end
end
