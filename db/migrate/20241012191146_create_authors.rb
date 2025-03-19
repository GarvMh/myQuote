class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :authorFirstName, null: false
      t.string :authorSurname, null: true
      t.text :authorDescription, null: true
      t.string :birthYear, null: true
      t.string :deathYear, null: true

      t.timestamps
    end
  end
end
