class CreateInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :inputs do |t|
      t.integer :line
      t.json :content
      t.references :download, foreign_key: true

      t.timestamps
    end
  end
end
