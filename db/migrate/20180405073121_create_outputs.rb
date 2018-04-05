class CreateOutputs < ActiveRecord::Migration[5.1]
  def change
    create_table :outputs do |t|
      t.integer :line
      t.json :content
      t.references :download, foreign_key: true
      t.string :type
      t.references :stream, foreign_key: true

      t.timestamps
    end
  end
end
