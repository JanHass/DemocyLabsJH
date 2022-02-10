class Add < ActiveRecord::Migration[5.2]
  def change
    add_reference :fellowship_users, :fellowship, index: true
    add_reference :fellowship_users, :user, index: true
  end
end
