class MovieService
  def top_movies
    page1 = MovieClient.get_data("/3/discover/movie?language=en-US&sort_by=vote_average.desc&page=1")
    page2 = MovieClient.get_data("/3/discover/movie?language=en-US&sort_by=vote_average.desc&page=2")
    movies = page1[:results] + page2[:results]
  end
end
