# frozen_string_literal: true

# Purpose: List model for the application. A list belongs to a user and has many items.
class List < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :list_items, dependent: :destroy

  # validates :name, presence: true
end
