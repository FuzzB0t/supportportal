class Dropadminstable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :admins
  	add_column :users, :admin, :boolean, default: false
  end
end
