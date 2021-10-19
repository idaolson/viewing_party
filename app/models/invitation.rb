class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user_id, presence: true
end
