class MovieFacade
  def top_rated_movies
    movie_data = MovieService.new.top_movies
    @movies = movie_data.map do |movie|
      Movie.new(movie)
    end 
  end
end
