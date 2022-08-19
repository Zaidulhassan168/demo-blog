require 'redis'
redis = Redis.new(host: "localhost", port: 6379, db: 11)
redis.set("mykey", "hello world")
redis.get("mykey")