class MovieService
  def self.top_movies
    page1 = MovieClient.get_data("/3/movie/top_rated?language=en-US&page=1")
    page2 = MovieClient.get_data("/3/movie/top_rated?language=en-US&page=2")
    page1[:results] + page2[:results]
  end

  def self.search_title(search)
    no_space = search.gsub(/\s+/, "%20")
    page1 = MovieClient.get_data("/3/search/movie?query=#{no_space}&page=1")
    page2 = MovieClient.get_data("/3/search/movie?query=#{no_space}&page=2")
    page1[:results] + page2[:results]
  end

  def self.search_id(id)
    data = MovieClient.get_data("/3/movie/#{id}?")
  end

  def self.cast_id(id)
    data = MovieClient.get_data("/3/movie/#{id}/credits?")
    data[:cast]
  end

  def self.review_id(id)
    data = MovieClient.get_data("/3/movie/#{id}/reviews?")
    data[:results]
  end

  def self.upcoming
    page1 = MovieClient.get_data("/3/movie/upcoming?language=en-US&page=1")
    page2 = MovieClient.get_data("/3/movie/upcoming?language=en-US&page=2")
    page1[:results] + page2[:results]
  end

  def self.recommended_id(id)
    recommended = MovieClient.get_data("/3/movie/#{id}/recommendations?")
    recommended[:results]
  end
end
