class AddDebateIdToObjections < ActiveRecord::Migration[5.2]
  def change
    add_reference :objections, :debates, foreign_key: true

  end
end
