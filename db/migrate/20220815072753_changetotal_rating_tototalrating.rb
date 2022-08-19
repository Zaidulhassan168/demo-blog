class ChangetotalRatingTototalrating < ActiveRecord::Migration[7.0]
  def change
     
    rename_column :posts, :totalRating, :total_rating
  end
end
