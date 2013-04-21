if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  ::REDIS_URL = {:host => uri.host, :port => uri.port, :password => uri.password}
  ::REDIS = Redis.new(::REDIS_URL)
end