class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :gakubu
      t.string :gakunen
      t.string :gakki
      t.text :memo

      t.timestamps
    end
  end
end
