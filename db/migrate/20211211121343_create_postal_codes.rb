class CreatePostalCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :postal_codes do |t|
      t.string :postal_code
      t.string :name

      t.timestamps
    end
    add_index :postal_codes, :postal_code, unique: true
  end
end
