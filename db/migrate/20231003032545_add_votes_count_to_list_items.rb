class AddVotesCountToListItems < ActiveRecord::Migration[7.0]
  def change
    add_column :list_items, :votes_count, :integer, default: 0
  end
end
