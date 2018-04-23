class TweetController < ApplicationController
  before_action :require_login
  # before_action :set_twitter_client, only: [:create, :can_tweet_destroy]

  def new
  end

  def create
    @tweet = Tweet.new

    begin
      tweet = twitter_client.update(params[:text])

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
    tweets = Tweet.where("destroy_date <= (now() + INTERVAL 60 SECOND)")
    begin
      tweets.each do |tweet|
        puts tweet.user.id
        # twitter_client.destroy(tweet.id)
        # Tweet.delete(tweet.id)
      end
      puts DateTime.now
    rescue => error
      STDERR.puts error
      redirect_to tweet_new_url, notice: error
    end
  end

  private

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token = session[:oauth_token]
      config.access_token_secret = session[:oauth_token_secret]
    end
  end

end
