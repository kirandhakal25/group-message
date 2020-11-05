import consumer from "./consumer"

let submit_messages;
$(document).on('turbolinks:load', function () {
  submit_messages()
});
submit_messages = function () {
  $('#message_content').on('keydown', function (event) {
    if (event.keyCode == 13) {
      $('input').click();
      event.target.value = '';
      event.preventDefault();
    }
  })
};
consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if (data.content != ''){
      $('#messages-table').append('<div class="message">' +
          '<div class="message-user">' + data.username + ":" + '</div>' +
          '<div class="message-content">' + data.content + '</div>' + '</div>')
    }
  }
});
