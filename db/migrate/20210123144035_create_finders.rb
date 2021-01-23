class CreateFinders < ActiveRecord::Migration[6.0]
  def change
    create_table :finders do |t|
      t.string :release
      t.string :duration
      t.string :language
      t.string :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
