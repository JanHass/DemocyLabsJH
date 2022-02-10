class AddingFellowshipsToPpd < ActiveRecord::Migration[5.2]
  def change
    add_reference :debates, :fellowship, index: true
    add_reference :proposals, :fellowship, index: true
    add_reference :polls, :fellowship, index: true
  end
end
