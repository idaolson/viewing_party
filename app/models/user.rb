class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :events, through: :invitations
  has_many :friends, through: :friendships

  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
end
