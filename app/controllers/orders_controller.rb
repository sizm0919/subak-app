class OrdersController < ApplicationController
    before_action :authenticate_account!, only: :create
    before_action :set_order, only: [:edit, :update, :destroy]

    def index
      @orders = Order.where(account_id: current_account)
    end
    
    def show
      @msg = '購入しました'
    end 

    def new
      @order = Order.new
    end
  
    def create
      @cart_items = current_cart.cart_item
      @cart_items.each do |obj|
        Order.create(
          quantity: obj.quantity,
          settlement_flag: "0",
          account_id: obj.cart.account_id,
          product_id:obj.product_id
        )
      end
     
      #カートをクリアにする
      current_cart.destroy
      
      redirect_to action: 'show'

    end

    def delete
      Order.find(params[:id]).destroy
      redirect_to action: 'index'
    end

    def order_position_delete
      Order.where(account_id: current_account, settlement_flag: '0').destroy_all
      redirect_to controller: 'top', action: 'position'
    end

    def buy
        
        if @card.blank?
          # カード情報がなければ、買えないから戻す
          redirect_to action: "new"
          flash[:alert] = '購入にはクレジットカード登録が必要です'
        else
          # 購入者もいないし、クレジットカードもあるし、決済処理に移行
          Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
          # 請求を発行
          Payjp::Charge.create(
          amount: @product.price,
          customer: @card.customer_id,
          currency: 'jpy',
          )

          flash[:notice] = '購入しました。'
          #redirect_to controller: 'products', action: 'show', id: @product.id
        end
    end

    private
  
      def set_order
        @order = Order.find(params[:id])
      end
  
      def order_params
        params.require(:order).permit(:account_id, :product_id, :quantity, :settlement_flag)
      end
  
end
