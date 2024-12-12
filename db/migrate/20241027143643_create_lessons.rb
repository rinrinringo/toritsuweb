class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.string :jugyou
      t.string :youbi

      t.timestamps
    end
  end
end
