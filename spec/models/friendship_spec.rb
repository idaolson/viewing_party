require 'rails_helper'

describe Friendship, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
end
