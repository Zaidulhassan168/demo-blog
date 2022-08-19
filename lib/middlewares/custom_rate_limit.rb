class CustomRateLimit
    TIME_PERIOD = 60 # no. of seconds
    LIMIT = 5 # no. of allowed requests per IP for unauthenticated user
  
    def initialize(app)
      @app = app
    end
  
    def call(env)
      if should_allow?(env)
        @app.call(env)
      else
        request_quota_exceeded
      end
    end
  
    private
    def should_allow?(env)
      return true if env['rack.session']['warden.user.user.key'].present?
  
      key = "IP:#{env['action_dispatch.remote_ip']}"
  
      REDIS.set(key, 0, nx: true, ex: TIME_PERIOD)
      REDIS.incr(key) > LIMIT ? false : true
    end
  
    def request_quota_exceeded
      [ 429, {}, ['Too many requests fired. Request quota exceeded!'] ]
    end
  end