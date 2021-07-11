class Customer::V1::MoviesController < ApplicationController

  def index
    movies = Movie.upcoming_movies
    render json: MovieSerializer.new(movies).to_json.merge(success: true), status: 200
  end

  def show
    finder = MovieDetail.new(movie).find
    if finder.successful?
      render json: { success: true, movie: finder.result }, status: 200
    else
      render json: { success: false, error: "Can not get the movie detail. Please try again" }, status: 500
    end
  rescue Timeout::Error => e
    render json: { success: false, error: "Service Unavailable. Try again later!" }, status: 503
  end

  private

  def movie
    @movie ||= Movie.find_by(slug: params[:id])
  end
end