class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :content, limit: 400
      t.references :user, null: false, foreign_key: true
      t.references :gossip, null: false, foreign_key: true
      t.timestamps
    end
  end
end
