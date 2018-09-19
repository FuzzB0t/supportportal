class DropDropsTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :drops
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
