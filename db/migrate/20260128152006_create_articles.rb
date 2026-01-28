class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :author_name

      t.timestamps
    end

    add_index :articles, :created_at
    add_index :articles, :author_name
  end
end
