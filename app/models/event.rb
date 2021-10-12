class Event < ApplicationRecord
  belongs_to :user

  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations
end
