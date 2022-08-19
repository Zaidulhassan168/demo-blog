class ChangeratingCountToratingCount < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :ratingCount, :rating_count
  end
end
