class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  #   def local_ip
  #     orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true
  #     UDPSocket.open do |s|
  #       s.connect '64.233.187.99', 1
  #       s.addr.last
  #     end
  #     ensure
  #       Socket.do_not_reverse_lookup = orig
  #  end

  TIME_PERIOD = 60 # no. of seconds
  LIMIT = 5 # no. of allowed requests per IP for unauthenticated user
  def authenticate(submitted_password)
    has_password?(submitted_password)
  end

  def limited_ip_address
    key = 'redis://localhost:6379/'
    REDIS.set(key, 0, nx: true, ex: TIME_PERIOD)
    !(REDIS.incr(key) > LIMIT)
  end

  # def current_user
  #     # If test situation when user is logged in
  #     User.first

  #     # If test situation when user is not logged in
  #     # nil
  # end
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # we need to provide session and current user
      session:,
      current_user:
    }
    # ip_add = local_ip
    # puts "ip #{ip_add}"
    result = DemoBlogSchema.execute(query, variables:, context:, operation_name:)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def current_user
    # if we want to change the sign-in strategy, this is the place to do it
    return unless session[:token]

    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
    token = crypt.decrypt_and_verify session[:token]
    user_id = token.gsub('user-id:', '').to_i
    User.find user_id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
