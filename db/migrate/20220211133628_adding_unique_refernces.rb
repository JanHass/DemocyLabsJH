class AddingUniqueRefernces < ActiveRecord::Migration[5.2]
  def change
    add_reference :fellowship_users, :fellowship, index: true, foreign_key: true, unique: true
    add_reference :fellowship_users, :user, index: true, foreign_key: true, unique: true
  end
end
