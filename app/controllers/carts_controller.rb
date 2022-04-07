class CartsController < ApplicationController
  layout 'carts'
  before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

    def show
      @cart_items = current_cart.cart_item
      @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    end
    
    # 商品一覧画面から、「商品購入」を押した時のアクション
    def add_item
      @cart_item ||= current_cart.cart_item.build(product_id: params[:product_id])
      
      if @cart_item.quantity.blank?
        @cart_item.quantity = params[:quantity].to_i
      else
        @cart_item.quantity += params[:quantity].to_i
      end

      @cart_item.save
      redirect_to show_path
    end

    # カート詳細画面から、「更新」を押した時のアクション
    def update_item
      @cart_item.update(quantity: params[:quantity].to_i)
      redirect_to show_path
    end
  
    # カート詳細画面から、「削除」を押した時のアクション
    def delete_item
      @cart_item.destroy
      redirect_to show_path
    end

    # カート詳細画面から、「購入手続きへ」を押した時のアクション
     def buy
      @msg = '購入手続き'
    end 

    def check
      @msg = '購入内容確認'
      @cart_items = current_cart.cart_item
      @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    end 
    
    private
  
    def setup_cart_item!
      @cart_item = current_cart.cart_item.find_by(product_id: params[:product_id])
    end

  end