class Vault < ApplicationRecord
  belongs_to :user
  validates :username, :password, presence: true
end
