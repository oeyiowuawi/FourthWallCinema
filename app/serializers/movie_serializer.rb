class MovieSerializer
  def initialize(movies)
    @movies = movies
  end

  def to_json
    {
      movies: extract_movie_details
    }
  end

  private

  attr_reader :movies

  def extract_movie_details
    movies.map do |movie|
      {
        name: movie.name,
        show_times: extract_show_time_details_for(movie)
      }
    end
  end

  def extract_show_time_details_for(movie)
    movie.show_times.map do |show_time|
      {
        time: show_time.time.to_s(:time),
        date: show_time.time.to_date.to_s,
        price: show_time.price.format
      }
    end
  end
end