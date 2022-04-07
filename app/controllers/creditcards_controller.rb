class CreditcardsController < ApplicationController
    require "payjp"
    before_action :set_card
  
    def show
      # すでにクレジットカードが登録しているか？
      if @card.present?
        # 登録している場合,PAY.JPからカード情報を取得する
        # PAY.JPの秘密鍵をセットする。
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        # PAY.JPから顧客情報を取得する。
        customer = Payjp::Customer.retrieve(@card.payjp_id)
        # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
        @card_info = customer.cards.retrieve(customer.default_card)
        # クレジットカード情報から表示させたい情報を定義する。
        # クレジットカードの画像を表示するために、カード会社を取得
        @card_brand = @card_info.brand
        # クレジットカードの有効期限を取得
        @exp_month = @card_info.exp_month.to_s
        @exp_year = @card_info.exp_year.to_s.slice(2,3) 
  
        # クレジットカード会社を取得したので、カード会社の画像をviewに表示させるため、ファイルを指定する。
        case @card_brand
        when "Visa"
          @card_image = "visa.svg"
        when "JCB"
          @card_image = "jcb.svg"
        when "MasterCard"
          @card_image = "master-card.svg"
        when "American Express"
          @card_image = "american_express.svg"
        when "Diners Club"
          @card_image = "dinersclub.svg"
        when "Discover"
          @card_image = "discover.svg"
        end
      end
    end
  
    def new
      @card = Creditcard.where(account_id: current_account.id).first
      logger.debug("デバッグ@card："+ @card.inspect)
      redirect_to action: "show" if @card.present?    
    end
  
    def create
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      if params['payjp-token'].blank?
        logger.debug("デバッグcreateparamsなし：")
        render "new"
      else
        customer = Payjp::Customer.create(
          description: 'test',
          email: current_account.email,
          card: params['payjp-token'],
          metadata: {account_id: current_account.id}
        )
        @card = Creditcard.new(account_id: current_account.id, payjp_id: customer.id)
        if @card.save
          redirect_to action: "show", notice:"支払い情報の登録が完了しました"
        else
          logger.debug("デバッグcreateカードsaveできない：")
          render 'new'
        end
      end
    end
  
    def destroy     
      # 今回はクレジットカードを削除するだけでなく、PAY.JPの顧客情報も削除する。これによりcreateメソッドが複雑にならない。
      # PAY.JPの秘密鍵をセットして、PAY.JPから情報をする。
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      # PAY.JPの顧客情報を取得
      customer = Payjp::Customer.retrieve(@card.payjp_id)
      customer.delete # PAY.JPの顧客情報を削除
      if @card.destroy # App上でもクレジットカードを削除
        redirect_to action: "show", notice: "削除しました"
      else
        redirect_to action: "show", alert: "削除できませんでした"
      end
    end
  
    private
    def set_card
      @card = Creditcard.where(account_id: current_account.id).first if Creditcard.where(account_id: current_account.id).present?
    end
  
end
