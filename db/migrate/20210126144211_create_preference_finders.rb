class CreatePreferenceFinders < ActiveRecord::Migration[6.0]
  def change
    create_table :preference_finders do |t|
      t.references :preference, null: false, foreign_key: true
      t.references :finder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
