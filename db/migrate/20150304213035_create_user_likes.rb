class CreateUserLikes < ActiveRecord::Migration
  def change
    create_table :user_likes do |t|
      t.belongs_to :user , null: false ,limit: 8 
      t.integer :userid_liked, null: false , limit: 8 
    end
    
    add_index :user_likes, [:user_id, :userid_liked]
  end
end