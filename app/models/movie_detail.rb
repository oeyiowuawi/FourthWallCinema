class MovieDetail
  attr_reader :result

  def initialize(movie)
    @movie = movie
    @success = false
    @result = {}
  end

  def find
    return {} unless movie.present?
    call_imdb_service
    process_service_result
    self
  end

  def successful?
    @success
  end

  private

  attr_reader :movie

  def call_imdb_service
    service = ImdbService.new(movie_id: movie.imdb_id)
    @service_result = service.get_movie_details
  end

  def process_service_result
    if @service_result[:success]
      process_imdb_result
      @success = true
    end
  end

  def process_imdb_result
    @result = @service_result[:data].select do |key, value|
      ["Title", "Year", "Rated", "Runtime", "imdbRating", "Released", "Genre"].include?(key)
    end
  end
end