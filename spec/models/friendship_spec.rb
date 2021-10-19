require 'rails_helper'

describe Friendship, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:friend_id)}
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
end
