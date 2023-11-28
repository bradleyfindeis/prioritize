# frozen_string_literal: true

# Purpose: List model for the application. A list belongs to a user and has many items.
class ListItem < ApplicationRecord
  belongs_to :list, dependent: :destroy
  has_many :votes, dependent: :destroy

  serialize :compared_list_item_ids, Array
end
