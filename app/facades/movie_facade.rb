class MovieFacade
  def top_rated_movies
    movie_data = MovieService.new.top_movies
    movie_data.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def search_by_title(title)
    search_data = MovieService.search_by_title(title)
    search_data.map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
