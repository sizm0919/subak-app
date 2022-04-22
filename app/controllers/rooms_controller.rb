class RoomsController < ApplicationController
  before_action :authenticate_account!, except: :adminshow
  before_action :create_room

  def index
    @current_account = request.env['warden'].user(:account)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def adminshow
    @room = Room.find(params[:id])
    @messages = @room.messages
    render 'rooms/show'
  end

  private
    def create_room
      if (Room.find_by id:params[:id]).nil?
        Room.create({id:params[:id]}) 
      end
    end

end
