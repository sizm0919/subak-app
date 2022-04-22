module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_account
    identified_by :current_admin

    def connect
      reject_unauthorized_connection unless find_verified_account || find_verified_admin
    end

    private

    def find_verified_account
      self.current_account = request.env['warden'].user(:account)
    end

    def find_verified_admin
      self.current_admin = request.env['warden'].user(:admin)
    end
  end
end