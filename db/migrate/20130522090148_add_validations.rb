class AddValidations < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, :null => false
    change_column :books, :title, :string, :null => false
    change_column :books, :author, :string, :null => false
    change_column :books, :isbn, :string, :null => false
    add_index :books, :isbn, :unique => true
    change_column :ratings, :book_id, :integer, :null => false
    change_column :ratings, :user_id, :integer, :null => false
  end
end
