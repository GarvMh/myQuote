class CreateFounders < ActiveRecord::Migration[7.0]
  def change
    create_table :founders do |t|
      t.string :name
      t.text :bio

      t.timestamps
    end
  end
end
