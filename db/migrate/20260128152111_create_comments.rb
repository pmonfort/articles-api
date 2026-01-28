class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :author_name
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end

    add_index :comments, :created_at
  end
end
