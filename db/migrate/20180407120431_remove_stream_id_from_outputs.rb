class RemoveStreamIdFromOutputs < ActiveRecord::Migration[5.1]
  def change
    remove_reference :outputs, :stream, foreign_key: true
  end
end
