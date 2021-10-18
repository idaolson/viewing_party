require 'rails_helper'

RSpec.describe MovieFacade, :vcr do
  describe 'multiple movies' do
    it 'returns an array of movie objects' do
      movie_facade = MovieFacade.new
      result = movie_facade.top_rated_movies
      expect(result.size).to eq(40)
      expect(result).to be_a(Array)
      expect(result.first).to be_a(Movie)
    end
  end

  describe 'specific movie' do
    it 'returns a specific movie object' do
      movie_facade = MovieFacade.new
      result = movie_facade.search_by_id(1573)
      expect(result).to be_a(Movie)
    end
  end

  describe 'search movie' do
    it 'returns a specific movie object' do
      movie_facade = MovieFacade.new
      result = movie_facade.search_by_title("Die Hard")
      expect(result).to be_a(Array)
      expect(result.first).to be_a(Movie)
    end
  end

  describe 'cast by movie id' do
    it 'returns a cast for a movie' do
      movie_facade = MovieFacade.new
      result = movie_facade.cast_by_id(1573)
      expect(result).to be_a(Array)
      expect(result.first).to be_a(Cast)
    end
  end

  describe 'review by movie id' do
    it 'returns a review for a movie' do
      movie_facade = MovieFacade.new
      result = movie_facade.review_by_id(1573)
      expect(result).to be_a(Array)
      expect(result.first).to be_a(Review)
    end
  end
end
