class MoviesController < ApplicationController
  def index
    movie_facade = MovieFacade.new
    @user = current_user

    if params[:search].present?
      @movies = movie_facade.search_by_title(params[:search])
    else
      @movies = movie_facade.top_rated_movies
    end
  end
end
