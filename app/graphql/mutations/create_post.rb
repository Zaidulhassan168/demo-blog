module Mutations
  class CreatePost < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, 'You need to login!'
      else
        true
      end
    end
    def local_ip
      orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true
      UDPSocket.open do |s|
        s.connect '64.233.187.99', 1
        s.addr.last
      end
      ensure
        Socket.do_not_reverse_lookup = orig
    end
    argument :title, String, required: true
    argument :content, String, required: true

    field :post, Types::PostType, null: false
    field :errors, [String], null: false
    TIME_PERIOD = 60 # no. of seconds
    LIMIT = 5 # no. of allowed requests per IP for unauthenticated user

    def limited_ip_address
      ip_addr = local_ip
      puts "hey ip here#{ip_addr}"
      key = ip_addr
      REDIS.set(key, 0, nx: true, ex: TIME_PERIOD)
      !(REDIS.incr(key) > LIMIT)
    end

    def resolve(title:, content:)
      

      if limited_ip_address == true
        # post = context[:current_user].posts.new(title: title, content: content)
        post = Post.create(userName: context[:current_user].email, title:, content:)
        {
          post:,
          errors: post.errors.full_messages
        }
      else
        {
          
          post: nil,
          errors: ['You have exceeded the limit of 5 requests per minute ']
        }
      end
    end
  end
end
