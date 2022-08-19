class Mutations::UpdatePost < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :title, String, required: false
  argument :content, String, required: false

  field :post, Types::PostType, null: false
  field :errors, [String], null: false
  TIME_PERIOD = 60 # no. of seconds
  LIMIT = 5 # no. of allowed requests per IP for unauthenticated user

  def limited_ip_address
    key = 'redis://localhost:6379/'
    REDIS.set(key, 0, nx: true, ex: TIME_PERIOD)
    !(REDIS.incr(key) > LIMIT)
  end


  def resolve(id:, title: nil, content: nil)
    if limited_ip_address==true
      post = Post.find(id)
      if post.update(title: title, content: content)
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
    else
      {
        post: nil,
        errors: ['You have exceeded the limit of 5 requests per minute']
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