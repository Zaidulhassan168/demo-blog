class Mutations::DestroyPost < Mutations::BaseMutation
  argument :id, ID, required: true

  field :post, Types::PostType, null: false
  field :errors, [String], null: false

  def resolve(id:)
    post = Post.find(id)
    if post.destroy
      {
        post: post,
        errors: []
      }
    else
      {
        post: nil,
        errors: post.errors.full_messages
      }
    end
  end
end
# Compare this snippet from app/graphql/types/post_type.rb:
# module Types
#   class PostType < Types::BaseObject
#     field :id, ID, null: false
#     field :title, String, null: false
#     field :body, String, null: false
#     field :published, Boolean, null: false
#     field :author, Types::UserType, null: false
#     field :comments, [Types::CommentType], null: false
#     field :created_at, GraphQL::Types::ISO8601DateTime, null: false
#     field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
#   end
# end
# Compare this snippet from app/graphql/types/user_type.rb:
# module Types
#   class UserType < Types::BaseObject
#     field :id, ID, null: false
#     field :username, String, null: false
#     field :email, String, null: false
#     field :posts, [Types::PostType], null: false
#     field :comments, [Types::CommentType], null: false
#     field :created_at, GraphQL::Types::ISO8601DateTime, null: false
#     field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
#   end
# end
# Compare this snippet from app/graphql/types/comment_type
# 
# Compare this snippet from app/graphql/mutations/create_user.rb:
# class Mutations::CreateUser < Mutations::BaseMutation
#