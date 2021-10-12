class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :events, through: :invitations
  has_many :friends, through: :friendships
end
