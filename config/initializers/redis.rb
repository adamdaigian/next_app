# See these links:
# https://gist.github.com/Diasporism/5631030
# http://tommy.chheng.com/2010/10/26/how-to-run-background-processes-using-resqueredis-in-a-ruby-on-rails-app/

#
require 'yaml'
YAML::ENGINE.yamler = 'psych'

Dir[File.join(Rails.root, 'app', 'jobs', '*.rb')].each { |file| require file }

REDIS_CONFIG 	= YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]

Resque.redis = Redis.new(:host => REDIS_CONFIG['host'], :port => REDIS_CONFIG['port'])

