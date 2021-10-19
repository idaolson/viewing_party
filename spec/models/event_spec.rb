require 'rails_helper'

describe Event, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:movie_id)}
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:day)}
    it {should validate_presence_of(:time)}
    it {should validate_presence_of(:duration)}
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:invitations) }
    it { should have_many(:users).through(:invitations) }
  end
end
