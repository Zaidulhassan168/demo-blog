module Mutations
  class SignOutUser < BaseMutation
    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself
   # class AuthProviderSignupData < Types::BaseInputObject
    #   argument :credentials, Types::AuthProviderCredentialsInput, required: false
    # end

    argument :username, String, required: true
    # argument :auth_provider, AuthProviderSignupData, required: false

    type Types::UserType

    def resolve(username: nil)
      user = User.find_by(username:)
      if context[:session][:token].nil?
        raise GraphQL::ExecutionError, 'You need to login!'

      else
        context[:session][:token] = nil
        raise GraphQL::ExecutionError, 'You are logged out'

      end

      user
    end
  end
end
