class TopController < ApplicationController
    before_action :authenticate_account!

    def index
        @ProductPriceData = ProductPrice.left_joins(:brand).select('productprices.*,brands.*')
            .where(price_date: Time.local(2021,8,1)..Float::INFINITY ).order(name: :desc)
        @CattleNumData = CattleNum.left_joins(:brand).select('cattlenums.*,brands.*')
            .where(date: Time.local(2021,8,1)..Float::INFINITY ).order(name: :desc)
    end

    def products
        @products = Product.left_joins(:brand).select('brands.*,products.*')
    end
    
    def position
        sql_position = "
            SELECT
                p.*,
                o.*,
                b.*,
                pp.*,
                p.option_premium * o.quantity AS premium_sum,
                CASE WHEN p.callput = 'コール' AND pp.price >  p.exercise_price THEN (pp.price - p.exercise_price) * o.quantity
                     WHEN p.callput = 'コール' AND pp.price <= p.exercise_price THEN 0
                     WHEN p.callput = 'プット' AND pp.price <  p.exercise_price THEN (p.exercise_price - pp.price) * o.quantity
                     WHEN p.callput = 'プット' AND pp.price >= p.exercise_price THEN 0
                ELSE 0 END AS settlement_amount,
                CASE WHEN p.callput = 'コール' AND pp.price >  p.exercise_price THEN ((pp.price - p.exercise_price) * o.quantity) - (p.option_premium * o.quantity)
                     WHEN p.callput = 'コール' AND pp.price <= p.exercise_price THEN 0 - (p.option_premium * o.quantity)
                     WHEN p.callput = 'プット' AND pp.price <  p.exercise_price THEN ((p.exercise_price - pp.price) * o.quantity) - (p.option_premium * o.quantity)
                     WHEN p.callput = 'プット' AND pp.price >= p.exercise_price THEN 0 - (p.option_premium * o.quantity)
                ELSE 0 END AS profit_loss_amount
            FROM orders o
            LEFT JOIN products p
                ON o.product_id = p.id
            LEFT JOIN brands b
                ON p.brand_id = b.id
            LEFT JOIN product_prices pp
                ON pp.brand_id = p.brand_id AND pp.price_date = ?
            WHERE o.settlement_flag = '0'
                AND o.account_id = ?
            "
        @date = '2021-11-01'
        @order_position = Order.find_by_sql([sql_position,@date, current_account])


        sql_setteled = "
            SELECT
                p.*,
                o.*,
                b.*,
                pp.*,
                p.option_premium * o.quantity AS premium_sum,
                CASE WHEN p.callput = 'コール' AND pp.price >  p.exercise_price THEN (pp.price - p.exercise_price) * o.quantity
                     WHEN p.callput = 'コール' AND pp.price <= p.exercise_price THEN 0
                     WHEN p.callput = 'プット' AND pp.price <  p.exercise_price THEN (p.exercise_price - pp.price) * o.quantity
                     WHEN p.callput = 'プット' AND pp.price >= p.exercise_price THEN 0
                ELSE 0 END AS settlement_amount,
                CASE WHEN p.callput = 'コール' AND pp.price >  p.exercise_price THEN ((pp.price - p.exercise_price) * o.quantity) - (p.option_premium * o.quantity)
                     WHEN p.callput = 'コール' AND pp.price <= p.exercise_price THEN 0 - (p.option_premium * o.quantity)
                     WHEN p.callput = 'プット' AND pp.price <  p.exercise_price THEN ((p.exercise_price - pp.price) * o.quantity) - (p.option_premium * o.quantity)
                     WHEN p.callput = 'プット' AND pp.price >= p.exercise_price THEN 0 - (p.option_premium * o.quantity)
                ELSE 0 END AS profit_loss_amount
            FROM orders o
            LEFT JOIN products p
                ON o.product_id = p.id
            LEFT JOIN brands b
                ON p.brand_id = b.id
            LEFT JOIN product_prices pp
                ON pp.brand_id = p.brand_id AND pp.price_date = p.settlement_date
            WHERE o.settlement_flag = '1'
                AND o.account_id = ?
            "
        @order_setteled = Order.find_by_sql([sql_setteled, current_account])
    end
    
    def profile
        @profile = Account.find(current_account.id)
        #業種の1がついたものはすべて業種名として1つの文字データに「、」区切りで結合
        industory = []
        if @profile.company.farmer == "1"
            industory.push('和牛生産者')
        end
        if @profile.company.wholesale == "1"
            industory.push('食肉卸業')
        end
        if @profile.company.retail == "1"
            industory.push('小売業')
        end
        if @profile.company.restaurant == "1"
            industory.push('外食業')
        end
        if @profile.company.homemeal == "1"
            industory.push('中食業')
        end
        @industory = industory.join(",")
    end

    def cart
        @msg = "cart."
    end

    def news
        # url = 'https://news.yahoo.co.jp/rss/topics/business.xml'
        # url = 'https://news.yahoo.co.jp/rss/media/nissyoku/all.xml' #Yahooニュースの日本食料新聞
        # url = 'https://news.google.com/rss/search?hl=ja&gl=JP&q=%E7%B1%B3&ceid=JP:ja' #Googleニュースでキーワード「米」指定
        url = 'https://news.google.com/rss/search?hl=ja&gl=JP&q=%E5%92%8C%E7%89%9B+inurl:https://news.nissyoku.co.jp&ceid=JP:ja'
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        render plain:Hash::from_xml(response.body).to_json      
    end

   
end
