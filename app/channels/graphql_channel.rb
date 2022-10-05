# class GraphqlChannel < ApplicationCable::Channel
#   def subscribed
#     posts = Post.all
#     stream_for posts
#   end

#   def unsubscribed
#     # Any cleanup needed when channel is unsubscribed
#   end
# end
# # ApplicationCable.server.broadcast(posts)
