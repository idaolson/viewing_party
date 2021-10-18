require 'rails_helper'

RSpec.describe Movie do
  let(:movie) { Movie.new({ id: 1, title: 'Movie', vote_average: 1, runtime: 120, overview: 'test'}) }

  it 'has attributes' do
    expect(movie.title).to eq('Movie')
    expect(movie.vote_average).to eq(1)
    expect(movie.id).to eq(1)
    expect(movie.runtime).to eq(120)
    expect(movie.overview).to eq('test')
  end
end
