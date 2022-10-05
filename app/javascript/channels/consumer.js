// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `bin/rails generate channel` command.

import { createConsumer } from "@rails/actioncable"

ActionCable.server.broadcast('Post_channel', posts.as_json)
// createConsumer('https://ws.demo-blog.com/cable')
export default createConsumer()
