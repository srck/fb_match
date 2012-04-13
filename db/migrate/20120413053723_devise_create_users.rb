class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string     :email
      t.string     :name,            :null => false
      t.string     :screen_name,     :null => false
      t.string     :image,           :null => false
      t.string     :url
      t.string     :locale
      t.string     :timezone
      t.datetime   :deleted_at 
      
      t.timestamps
    end

    add_index :users, :screen_name, :unique => true
  end
end
