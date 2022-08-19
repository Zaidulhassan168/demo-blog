require 'redis'
REDIS = Redis.new(url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/' })


# if Rails.env.development?
#     puts "dev: #{ENV['REDIS_URL']}"
#     uri = URI.parse(ENV["REDIS_URL"])
#   else
#     puts "not dev"
#     uri = URI.parse("redis://localhost:6379")
# end

# if 'REDIS_URL' in env:
#     REDIS_URL = env['REDIS_URL']

# else:
#     REDIS_URL = None


# if REDIS_URL is not  NIL
#     CACHES = {
#         'default': {
#             'BACKEND': 'redis_cache.cache.RedisCache',
#             'LOCATION': REDIS_URL,
#             'KEY_PREFIX': APP_NAME,
#             'OPTIONS': {
#                 'CLIENT_CLASS': 'redis_cache.client.DefaultClient',
#             }
#         }
#     }





# if Rails.env.production?
#     puts "production: #{ENV['REDIS_URL']}"
#     uri = URI.parse(ENV["REDIS_URL"])
#   else
#     puts "not production"
#     uri = URI.parse("redis://localhost:3000r")
#   end