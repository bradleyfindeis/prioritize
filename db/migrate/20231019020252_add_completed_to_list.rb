class AddCompletedToList < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :completed, :boolean, default: false
  end
end
