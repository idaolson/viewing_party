class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :events
  has_many :friends, through: :friendships
  has_many :invited_events, through: :invitations, source: :event

  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password, confirmation: {case_sensitive: true}
end
