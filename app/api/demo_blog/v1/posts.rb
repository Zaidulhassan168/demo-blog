# module DemoBlog
  module V1
    class Posts < Grape::API
      version 'v1', using: :path
      format :json
      content_type :json, 'application/json'
      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ error: e.message }, 404)
      end
    end
  end
# end
