module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_account

    def connect
      reject_unauthorized_connection unless find_verified_account
    end

    private

    def find_verified_account
      self.current_account = request.env['warden'].user(:account)
    end
  end
end