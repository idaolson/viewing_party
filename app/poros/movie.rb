class Movie
  attr_reader :title, :vote_average, :id, :runtime, :overview, :genres

  def initialize(data)
    @title = data[:title]
    @vote_average = data[:vote_average]
    @id = data[:id]
    @runtime = data[:runtime]
    @overview = data[:overview]
    @genres = get_genres(data)
  end

  def get_genres(data)
    if !data[:genres].nil?
      data[:genres].map do |genre|
        genre[:name]
      end 
    end
  end
end
