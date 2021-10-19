require 'rails_helper'

RSpec.describe MovieService, :vcr do
  it "#top_movies" do
    movies = MovieService.top_movies
    expect(movies).to be_an(Array)
    expect(movies.size).to eq(40)
    movie_data = movies.first
    expect(movie_data).to have_key(:id)
    expect(movie_data).to have_key(:title)
    expect(movie_data).to have_key(:vote_average)
  end

  it "#search_title" do
    movies = MovieService.search_title("Die Hard")
    expect(movies).to be_an(Array)
    movie_data = movies.first
    expect(movie_data).to have_key(:id)
    expect(movie_data).to have_key(:title)
    expect(movie_data).to have_key(:vote_average)
  end

  it "#search_id" do
    movie = MovieService.search_id(1573)
    expect(movie).to be_a(Hash)
    expect(movie).to have_key(:id)
    expect(movie).to have_key(:title)
    expect(movie).to have_key(:vote_average)
    expect(movie).to have_key(:genres)
    expect(movie).to have_key(:runtime)
    expect(movie).to have_key(:overview)
  end

  it "#cast_id" do
    cast = MovieService.cast_id(1573)
    expect(cast).to be_an(Array)
    cast_data = cast.first
    expect(cast_data).to have_key(:name)
    expect(cast_data).to have_key(:character)
  end

  it "#review_id" do
    reviews = MovieService.review_id(1573)
    expect(reviews).to be_an(Array)
    review_data = reviews.first
    expect(review_data).to have_key(:author)
    expect(review_data).to have_key(:content)
  end

  it '#upcoming' do
    movies = MovieService.upcoming
    expect(movies).to be_an(Array)
    expect(movies.size).to eq(40)
    movie_data = movies.first
    expect(movie_data).to have_key(:id)
    expect(movie_data).to have_key(:title)
    expect(movie_data).to have_key(:vote_average)
  end

  it '#recommended_id' do
    recommended = MovieService.recommended_id(1573)
    expect(recommended).to be_a(Array)
    expect(recommended.first).to have_key(:id)
    expect(recommended.first).to have_key(:title)
    expect(recommended.first).to have_key(:vote_average)
    expect(recommended.first).to have_key(:overview)
  end
end
