class Change < ActiveRecord::Migration[5.2]
  def change
    change_column :fellowships, :user_required_full_name, :boolean, default: false
  end
end
