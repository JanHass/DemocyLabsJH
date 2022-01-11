class DropTablename < ActiveRecord::Migration[5.2]
  def change
    drop_table :fellowships
    drop_table :fellowship_translations
  end
end
