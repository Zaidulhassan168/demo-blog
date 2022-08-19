# module DemoBlog
  class Root < Grape::API
    # prefix 'api'
    mount V1::Posts
  end
# end
