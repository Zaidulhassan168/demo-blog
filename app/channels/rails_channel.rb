class RailsChannel < ApplicationCable::Channel
  def subscribed
    
    stream_for "rails_channel"
    # transmit(posts) # send message to current connection (sender)
  end

  def speak
    # num = args.to_json
    result = Post.limit(1)
    # result = posts.
    stream_for "rails_channel"
    transmit(result) # send message to current connection (sender)
    # puts "send this data.#{params}"
    # ActionCable.server.broadcast("rails_channel", "send this data #{params}")
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stream_for "Thank you! Good Bye!"
  end
end
