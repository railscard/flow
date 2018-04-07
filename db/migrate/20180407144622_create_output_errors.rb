class CreateOutputErrors < ActiveRecord::Migration[5.1]
  def change
    create_table :output_errors do |t|
      t.references :download, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
