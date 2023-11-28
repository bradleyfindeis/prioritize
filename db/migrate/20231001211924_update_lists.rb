class UpdateLists < ActiveRecord::Migration[7.0]
  def change
    # Remove the items column from the lists table
    remove_column :lists, :items
    add_reference :lists, :user, null: true, foreign_key: true

    # Create the list_items table
    create_table :list_items do |t|
      t.string :name
      t.references :list, null: true, foreign_key: true

      t.timestamps
    end
  end
end
