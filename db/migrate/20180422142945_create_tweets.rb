class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :tweet_id, null: false, limit: 5
      t.datetime :destroy_date, null: false

      t.timestamps
    end
    add_index :tweets, :destroy_date
  end
end
