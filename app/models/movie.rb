class Movie < ApplicationRecord
  has_many :show_times

  validates :slug, presence: true
  validates :imdb_id, presence: true
  validates :name, presence: true
end
