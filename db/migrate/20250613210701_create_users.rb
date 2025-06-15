class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :pseudo, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.text :bio
      t.timestamps
    end
    add_index :users, [ :email, :pseudo ], unique: true
  end
end
