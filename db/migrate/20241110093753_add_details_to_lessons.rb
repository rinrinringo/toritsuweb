class AddDetailsToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :overall, :integer
    add_column :lessons, :level, :integer
  end
end
