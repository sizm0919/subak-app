class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    include CartsHelper 

    private
    
    def after_sign_in_path_for(resource)
        case resource
        when Admin
          admins_index_path
        when Account
          root_path
        end
    end
      
    def after_sign_out_path_for(resource)
        root_path    
    end

end
