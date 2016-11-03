class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''

      t.timestamps
    end

    add_index :authors, :email, unique: true
  end
end
