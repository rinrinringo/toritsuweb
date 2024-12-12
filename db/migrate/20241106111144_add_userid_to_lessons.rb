class AddUseridToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :user_id, :integer
  end
end
