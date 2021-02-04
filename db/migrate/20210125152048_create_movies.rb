# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :overview
      t.string :vote_average
      t.references :finder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
