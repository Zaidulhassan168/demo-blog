class AddUserNameToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :userName, :string
  end
end
