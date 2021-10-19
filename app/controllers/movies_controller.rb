class MoviesController < ApplicationController
  def index
    movie_facade = MovieFacade.new
    @user = current_user

    if params[:search].present?
      @movies = movie_facade.search_by_title(params[:search])
    elsif params[:upcoming].present?
      @movies = movie_facade.upcoming_movies
    else
      @movies = movie_facade.top_rated_movies
    end
  end

  def show
    movie_facade = MovieFacade.new
    @movie = movie_facade.search_by_id(params[:id])
    @user = current_user
    @cast = movie_facade.cast_by_id(params[:id])
    @reviews = movie_facade.review_by_id(params[:id])
    @recommended = movie_facade.recommended_by_id(params[:id])
  end
end
