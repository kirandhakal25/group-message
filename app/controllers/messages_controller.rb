class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_messages

  def index
  end

  def create
    message = current_user.messages.new(message_params)
    if message.save
      ActionCable.server.broadcast 'room_channel',
                                   content: message.content,
                                   username: message.user.username
    end
    # message = current_user.messages.new(message_params)
    # if message.save
    #   redirect_to messages_url
    # else
    #   render 'index'
    # end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def get_messages
    @messages = Message.order(:created_at).last(50)
    @message = current_user.messages.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:content)
  end

end
