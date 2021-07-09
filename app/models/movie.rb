class Movie < ApplicationRecord

  validates :slug, presence: true
  validates :imdb_id, presence: true
  validates :name, presence: true
end
