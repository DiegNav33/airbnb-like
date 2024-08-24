class AddUserToFavourites < ActiveRecord::Migration[7.1]
  def change
    add_reference :favourites, :user, null: false, foreign_key: true
  end
end
