require 'rails_helper'

describe Event, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:invitations) }
    it { should have_many(:users).through(:invitations) }
  end
end
