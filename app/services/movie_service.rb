class MovieService
  def top_movies
    page1 = MovieClient.get_data("/3/discover/movie?language=en-US&sort_by=vote_average.desc&page=1")
    page2 = MovieClient.get_data("/3/discover/movie?language=en-US&sort_by=vote_average.desc&page=2")
    page1[:results] + page2[:results]
  end

  def search_by_title(search)
    page1 = MovieClient.get_data("/3/search/movie&query=#{search}&page=1")
    page2 = MovieClient.get_data("/3/search/movie&query=#{search}&page=2")
    # https://api.themoviedb.org/3/search/movie?api_key=****&language=en-US&query=shrek&page=1&include_adult=false
    page1[:results] + page2[:results]
  end
end
