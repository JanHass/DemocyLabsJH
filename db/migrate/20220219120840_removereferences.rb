class Removereferences < ActiveRecord::Migration[5.2]
  def change
    remove_reference :fellowship_users, :fellowship, index: true
    remove_reference :fellowship_users, :user, index: true
  end
end
