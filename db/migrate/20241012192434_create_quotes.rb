class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.boolean :isPrivate, default: false, null: false
      t.text :quoteDescription, null: false
      t.text :comment, null: true
      t.string :publicationYear, null: true
      t.references :user, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end

