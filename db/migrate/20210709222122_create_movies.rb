class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :slug
      t.string :imdb_id
      t.timestamps
    end
  end
end
