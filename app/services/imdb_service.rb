class ImdbService
  def initialize(movie_id:)
    @movie_id = movie_id
  end

  def get_movie_details
    url = "http://www.omdbapi.com/?apikey=#{ENV['IMDB_API_KEY']}&i=#{movie_id}"
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    response = make_request(uri, request)
    parse_response(response)
  end

  private

  attr_reader :movie_id

  def make_request(uri, request)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def parse_response(response)
    if response.code == "200"
      { success: true, data: JSON.parse(response.body) }
    else
      { success: false}
    end
  end

end