class Movie < ApplicationRecord
  has_many :show_times

  validates :slug, presence: true
  validates :imdb_id, presence: true
  validates :name, presence: true

  scope :upcoming_movies,  -> { joins(:show_times).includes(:show_times).merge(ShowTime.upcoming) }
end
