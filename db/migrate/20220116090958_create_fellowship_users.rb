class CreateFellowshipUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :fellowship_users do |t|
      t.integer :fellowship_id
      t.integer :user_id
      t.boolean :is_fellowship_administrator, default: false
      t.boolean :is_fellowship_moderator, default: false

      t.timestamps
    end
  end
end
