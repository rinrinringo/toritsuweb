class AddUserIdToCalls < ActiveRecord::Migration[6.1]
  def change
    add_column :calls, :user_id, :integer
  end
end
