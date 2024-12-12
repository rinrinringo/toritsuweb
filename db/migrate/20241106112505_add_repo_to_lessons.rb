class AddRepoToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :repo, :text
  end
end
