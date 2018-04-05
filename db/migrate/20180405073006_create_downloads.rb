class CreateDownloads < ActiveRecord::Migration[5.1]
  def change
    create_table :downloads do |t|
      t.string :name
      t.timestamp :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
