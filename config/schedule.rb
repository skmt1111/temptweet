# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
env :PATH, ENV['PATH']
require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"
#
# every 1.minute do
#   runner "TweetController.new.can_tweet_destroy"
# end
every 1.minute do
  rake "twitter:destroy"
end

# Learn more: http://github.com/javan/whenever
