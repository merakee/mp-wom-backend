class AddNewFieldsAndModifyUsers < ActiveRecord::Migration
  def change
    remove_column :users, :userid

    add_column :users, :nickname, :string, default: "anonim", null: false
    add_column :users, :avatar, :string, default: "", null: false
    add_column :users, :bio, :text, default: " ", null: false
    add_column :users, :social_tags, :string, array: true, default: [], null: false
    add_column :users, :hometown, :string, default: " ", null: false
    add_column :users, :verified, :boolean, default: false, null: false
    add_column :users, :like_count, :integer, default: 0, null: false
  end
end
