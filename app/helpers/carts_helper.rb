module CartsHelper
    def current_cart
        if current_account
          # ユーザーとカートの紐付け
          if Cart.where(account_id: current_account.id).blank?
            current_cart = Cart.new
            current_cart.account_id = current_account.id
            current_cart.save
           else
            current_cart = current_account.cart
          end
        else
          # セッションとカートの紐付け
          current_cart = Cart.find_by(id: session[:cart_id]) || Cart.create
          session[:cart_id] ||= current_cart.id
        end
        current_cart
    end
    

  end
