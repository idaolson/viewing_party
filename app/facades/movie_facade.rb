class MovieFacade
  def top_rated_movies
    movie_data = MovieService.top_movies
    movie_data.map do |movie|
      Movie.new(movie)
    end
  end

  def upcoming_movies
    movie_data = MovieService.upcoming
    movie_data.map do |movie|
      Movie.new(movie)
    end
  end

  def search_by_title(title)
    search_data = MovieService.search_title(title)
    search_data.filter_map do |movie|
      Movie.new(movie) if movie[:title].include?(title)
    end
  end

  def search_by_id(id)
    movie_data = MovieService.search_id(id)
    Movie.new(movie_data)
  end

  def cast_by_id(id)
    cast_data = MovieService.cast_id(id)
    cast = cast_data.map do |member|
      Cast.new(member) unless member[:character].nil?
    end
    cast.take(10)
  end

  def review_by_id(id)
    review_data = MovieService.review_id(id)
    review_data.filter_map do |review|
      Review.new(review) unless review[:author].nil?
    end
  end

  def recommended_by_id(id)
    recommended = MovieService.recommended_id(id)
    rec = recommended.map do |movie_data|
      Movie.new(movie_data)
    end
    rec.take(3)
  end
end
