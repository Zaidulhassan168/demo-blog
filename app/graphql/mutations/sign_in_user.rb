module Mutations
  class SignInUser < BaseMutation
    null true
    argument :credentials, Types::AuthProviderCredentialsInput, required: false
    field :token, String, null: true
    field :user, Types::UserType, null: true
    def resolve(credentials: nil)
      # basic validation
      return unless credentials

      user = User.find_by email: credentials[:email]
      # ensures we have the correct user
      return unless user
      # ensures the user has entered the correct password
      return unless user.authenticate
      
      ip_add = user.local_ip

      # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{user.id}")
      context[:session][:token] = token
      puts "here is the ip #{ip_add}"
      puts "user data #{user.to_json}"
      puts "token #{token}"
      puts " current user #{context}"
      { user:, token: }
    end
  end
end
