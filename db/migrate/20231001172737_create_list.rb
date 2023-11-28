class CreateList < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :items, array: true, default: []

      t.timestamps
    end
  end
end
