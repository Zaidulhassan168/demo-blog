import consumer from "channels/consumer"

consumer.subscriptions.create("GraphqlChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    GraphqlChannel.send({ sent_by: "Paul", body: "This is a cool chat app." })
    print ("hello")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});

GraphqlChannel.send({ sent_by: "Paul", body: "This is a cool chat app." })