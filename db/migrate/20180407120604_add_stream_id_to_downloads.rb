class AddStreamIdToDownloads < ActiveRecord::Migration[5.1]
  def change
    add_reference :downloads, :stream, foreign_key: true
  end
end
