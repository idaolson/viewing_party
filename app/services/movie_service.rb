class MovieService
  def top_movies
    page1 = MovieClient.get_data("/3/discover/movie?language=en-US&sort_by=vote_average.desc&page=1")
    page2 = MovieClient.get_data("/3/discover/movie?language=en-US&sort_by=vote_average.desc&page=2")
    page1[:results] + page2[:results]
  end

  def search_title(search)
    no_space = search.gsub(/\s+/, "%20")
    page1 = MovieClient.get_data("/3/search/movie?query=#{no_space}&page=1")
    page2 = MovieClient.get_data("/3/search/movie?query=#{no_space}&page=2")
    page1[:results] + page2[:results]
  end

  def search_id(id)
    data = MovieClient.get_data("/3/movie/#{id}?")
  end

  def cast_id(id)
    data = MovieClient.get_data("/3/movie/#{id}/credits?")
    data[:cast]
  end

  def review_id(id)
    data = MovieClient.get_data("/3/movie/#{id}/reviews?")
    data[:results]
  end
end
