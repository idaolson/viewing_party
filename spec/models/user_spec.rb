require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it { should have_many(:events) }
    it { should have_many(:friendships) }
    it { should have_many(:invitations) }
    it { should have_many(:friends).through(:friendships) }
  end

  describe 'instance methods' do
    it 'can call #friends' do
      user1 = User.create!(email: "kevin.mugele@gmail.com", password: "123123", name: "Kevin")
      user2 = User.create!(email: "idaolson@gmail.com", password: "123123", name: "Ida")
      user3 = User.create!(email: "steve@gmail.com", password: "12asdad333", name: "Steve")

      friendship1 = Friendship.create!(user_id: user1.id, friend_id: user2.id)
      friendship2 = Friendship.create!(user_id: user1.id, friend_id: user3.id)

      expect(user1.friends).to eq([user2, user3])
    end
  end
end
