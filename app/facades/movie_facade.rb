class MovieFacade
  def top_rated_movies
    movie_data = MovieService.new.top_movies
    movie_data.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def search_by_title(title)
    search_data = MovieService.new.search_title(title)
    search_data.filter_map do |movie_data|
      if movie_data[:title].include?(title)
        Movie.new(movie_data)
      end
    end
  end

  def search_by_id(id)
    movie_data = MovieService.new.search_id(id)
    Movie.new(movie_data)
  end

  def cast_by_id(id)
    cast_data = MovieService.new.cast_id(id)
    cast = cast_data.map do |cast_data|
      if !cast_data[:character].nil?
        Cast.new(cast_data)
      end
    end
    cast.take(10)
  end
end
