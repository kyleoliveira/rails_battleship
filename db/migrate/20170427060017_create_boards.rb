class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|

      t.timestamps
    end

    change_table :battleships do |t|
      t.belongs_to :board, index: true
    end
  end
end
