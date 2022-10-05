import consumer from "channels/consumer"

consumer.subscriptions.create("RailsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    RailsChannel.send({ sent_by: "Paul", body: "This is a cool chat app." })
    console.log("Connected to WallChannel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  s: function() {
    return this.perform('s');
  }
});
