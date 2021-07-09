class CreateShowTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :show_times do |t|
      t.datetime :time
      t.references :movie, null: false, foreign_key: true
      t.monetize :price
      t.timestamps
    end
  end
end
