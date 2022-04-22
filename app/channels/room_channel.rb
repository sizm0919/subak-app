class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room']}" 
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    #ActionCable.server.broadcast 'room_channel', message: data['message']
    if current_admin.nil? then
      Message.create! content: data['message'], account_id: current_account.id, room_id: params['room']
    else
      Message.create! content: data['message'], account_id: 1, room_id: params['room']
    end  
  end
end
