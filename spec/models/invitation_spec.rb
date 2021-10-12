require 'rails_helper'

describe Invitation, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }
  end
end
