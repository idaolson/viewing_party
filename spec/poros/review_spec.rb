require 'rails_helper'

RSpec.describe Review do
  let(:review) { Review.new({ author: 'Kevin', content: 'Loved it!' }) }

  it 'has attributes' do
    expect(review.author).to eq('Kevin')
    expect(review.content).to eq('Loved it!')
  end
end
