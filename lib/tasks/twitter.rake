namespace :twitter do
  desc "tweetを削除するタスク"
  task destroy: :environment do
    TweetController.new.can_tweet_destroy
  end
end
