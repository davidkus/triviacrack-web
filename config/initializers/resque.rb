Resque.redis = Redis.new(url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" })
Resque.after_fork = proc { ActiveRecord::Base.establish_connection }
