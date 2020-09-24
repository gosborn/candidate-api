class AddDefaultToReviewed < ActiveRecord::Migration[5.2]
  def change
    change_column :candidates, :reviewed, :boolean, default: false
  end
end
