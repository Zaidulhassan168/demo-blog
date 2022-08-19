class AddRatingCountToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :ratingCount, :integer
  end
end
