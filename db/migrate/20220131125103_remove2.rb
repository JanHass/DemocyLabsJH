class Remove2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :fellowship_users, :user_id, :integer
    remove_column :fellowship_users, :fellowship_id, :integer
  end
end
