class CreateBattleships < ActiveRecord::Migration[5.0]
  def change
    create_table :battleships do |t|
      t.integer :x
      t.integer :y
      t.boolean :bow_hit, default: false
      t.boolean :middle_hit, default: false
      t.boolean :aft_hit, default: false

      t.timestamps
    end
  end
end
