class MoviesController < ApplicationController
  def index
    @movie_facade = MovieFacade.new
    @movies = @movie_facade.top_rated_movies
    @user = current_user
  end
end
