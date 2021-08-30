class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, :password, presence: true

  has_many :vaults
end
