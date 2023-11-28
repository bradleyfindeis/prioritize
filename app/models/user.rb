class User < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_secure_password
end
