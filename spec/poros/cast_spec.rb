require 'rails_helper'

RSpec.describe Cast do
  let(:cast) { Cast.new({ character: 'Hermione', name: 'Emma' }) }

  it 'has attributes' do
    expect(cast.character).to eq('Hermione')
    expect(cast.name).to eq('Emma')
  end
end
