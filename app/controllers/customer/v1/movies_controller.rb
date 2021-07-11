class Customer::V1::MoviesController < ApplicationController

  def index
    movies = Movie.upcoming_movies
    render json: MovieSerializer.new(movies).to_json, status: 200
  end

  def show
    finder = MovieDetail.new(movie).find
    if finder.successful?
      render json: { movie: finder.result }, status: 200
    else
      render json: { error: "Can not get the movie detail. Please try again" }, status: 500
    end
  rescue Timeout::Error => e
    render json: { error: "Service Unavailable. Try again later!" }, status: 503
  end

  private

  def movie
    @movie ||= Movie.find_by(slug: params[:id])
  end
end