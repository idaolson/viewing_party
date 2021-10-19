class Event < ApplicationRecord
  belongs_to :user
  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations

  validates :movie_id, presence: true
  validates :title, presence: true
  validates :day, presence: true
  validates :time, presence: true
  validates :duration, presence: true
end
