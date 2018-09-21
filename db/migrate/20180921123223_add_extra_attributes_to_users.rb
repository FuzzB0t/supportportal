class AddExtraAttributesToUsers < ActiveRecord::Migration[5.2]
  def up
  	add_column :users, :sign_in_count, :integer, default: 0, null: false
  	add_column :users, :current_sign_in_at, :datetime
  	add_column :users, :last_sign_in_at, :datetime
  	add_column :users, :current_sign_in_ip, :inet
  	add_column :users, :last_sign_in_ip, :inet
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_index :users, :confirmation_token, unique: true
  end
end
