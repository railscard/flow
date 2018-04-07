class RemoveResponceFromOutput < ActiveRecord::Migration[5.1]
  def change
    remove_column :outputs, :responce, :string
  end
end
