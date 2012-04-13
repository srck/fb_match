class CreateConnects < ActiveRecord::Migration
  def change
    create_table :connects do |t|
      t.references :user,            :null => false
      t.string     :provider,        :null => false
      t.string     :uid,             :null => false
      t.string     :token,           :null => false
      
      t.timestamps
    end

    add_index :connects, :user_id
    add_index :connects, [:provider, :uid],  :unique => true
  end
end
