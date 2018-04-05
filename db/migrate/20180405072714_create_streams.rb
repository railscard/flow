class CreateStreams < ActiveRecord::Migration[5.1]
  def change
    create_table :streams do |t|
      t.string :name
      t.timestamp :date
      t.text :code
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
