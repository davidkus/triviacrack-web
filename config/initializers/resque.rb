Resque.redis = $redis
Resque.after_fork = proc { ActiveRecord::Base.establish_connection }
