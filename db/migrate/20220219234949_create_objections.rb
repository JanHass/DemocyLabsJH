class CreateObjections < ActiveRecord::Migration[5.2]
  def change
    create_table :objections do |t|
      t.text :body
      t.text :sources
      t.string :email
      t.float :rating
      t.integer :likes
      t.integer :dislikes
      t.integer :reported
      t.references :user, foreign_key: true
      t.references :pro_contra, foreign_key: true
      

      t.timestamps
    end
  end
end
