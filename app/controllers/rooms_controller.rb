class RoomsController < ApplicationController
  before_action :authenticate_account!

  def index
    @rooms = Room.all.order(:id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end
end
