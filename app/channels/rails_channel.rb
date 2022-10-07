class RailsChannel < ApplicationCable::Channel
  def subscribed
    
    stream_for "rails_channel"
    # transmit(posts) # send message to current connection (sender)
    # ActionCable.server.broadcast("rails_channel")
  end

  def getAllProducts
    # num = args.to_json
    result = Post.limit(10)
    # result = posts.
    # stream_for "rails_channel"
    transmit(result) # send message to current connection (sender)
    # puts "send this data.#{params}"
    ActionCable.server.broadcast("rails_channel", result)
  end
  def getSpecificProduct(params)
    # num = args.to_json
     puts "id is #{params['args']}"
    result = Post.find(params['args'])
    # result = posts.
    # stream_for "rails_channel"
    transmit(result) # send message to current connection (sender)
    # puts "send this data.#{params}"
    # ActionCable.server.broadcast("rails_channel", "send this data #{params}")
  end

  def getRating (params)
    result = Post.find(params['args'])
    obj = { "total_rating": result.total_rating, "rating_count": result.rating_count, "avg_rating": result.avg_rating , "title": result.title}
    transmit(obj)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stream_for "Thank you! Good Bye!"
  end
end
