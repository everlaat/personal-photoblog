class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :author, foreign_key: true
      t.string :title
      t.text :content
      t.datetime :posted_at

      t.timestamps
    end
  end
end
