class TweetController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    @tweet = Tweet.new

    begin
      tweet = twitter_client(current_user.id).update(params[:text])

      @tweet.user = current_user
      @tweet.tweet_id = tweet.id
      minute = params[:num].to_i
      @tweet.destroy_date = DateTime.now + Rational(minute, 24 * 60)
      @tweet.save
      redirect_to tweet_new_url, notice: 'つぶやきました！'
    rescue => error
      STDERR.puts error
      redirect_to tweet_new_url, notice: error
    end
  end

  def can_tweet_destroy
    tweets = Tweet.where("destroy_date <= (now() + INTERVAL 30 SECOND)")
    tweets.each do |tweet|
      begin
        twitter_client(tweet.user.id).destroy_status(tweet.tweet_id)
        puts "succese!"
      rescue => error
        STDERR.puts error
      ensure
        Tweet.delete(tweet)
      end
    end
  end

  def twitter_client(user_id)
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      user = User.find(user_id)
      config.access_token = user.token
      config.access_token_secret = user.secret
    end
  end

end
