class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.references :post, foreign_key: true
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
