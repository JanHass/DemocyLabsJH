class ChangeValueOfShortDescription < ActiveRecord::Migration[5.2]
  def change
    change_column :fellowships, :short_description, :text
  end
end
