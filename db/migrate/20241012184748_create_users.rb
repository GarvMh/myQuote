class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :userFirstName, null: false
      t.string :userSurname, null: false
      t.string :emailAddress, null: false
      t.string :password_digest, null: false
      t.boolean :isAdmin, default:false
      t.string :accountStatus, null: false

      t.timestamps
    end
    add_index :users, :emailAddress, unique: true
  end
end
