class AddAvgRatingToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :avg_rating, :integer
  end
end
