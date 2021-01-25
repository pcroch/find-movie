class CreateFinders < ActiveRecord::Migration[6.0]
  def change
    create_table :finders do |t|
      t.string :release
      t.string :duration
      t.string :language, array: true, default: []
      t.string :rating, array: true, default: []
      # t.string :title
      # t.text :overview
      # t.string :vote_average
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end


