class CreateProContras < ActiveRecord::Migration[5.2]
  def change
    create_table :pro_contras do |t|
      t.string :tag
      t.text :body
      t.text :sources
      t.string :email
      t.float :rating
      t.integer :likes
      t.integer :dislikes
      t.integer :reported
      t.integer :move
      t.integer :pc
      t.references :user, foreign_key: true
      t.references :debate, foreign_key: true
      t.references :proposal, foreign_key: true
      t.references :poll, foreign_key: true
      t.references :vote, foreign_key: true
      t.references :fellowship, foreign_key: true

      t.timestamps
    end
  end
end
