class AdminProductsController < ApplicationController
  require 'csv'

  before_action :authenticate_admin!
  before_action :set_q, only: [:index, :search, :output]
  before_action :set_option, only: [:index, :search,]
  
  def index
    @@admin_products = Product.all
    @admin_products = Product.all
  end

  def new
    @admin_product = Product.new
  end

  def create
    if request.post? then
      Product.create(product_params)
      redirect_to '/admin_products'
    else
      @product = Product.new
    end
  end

  def edit
    @admin_product = Product.find(params[:id])
  end

  def update
    @admin_product = Product.find(params[:id])

    if @admin_product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admin_product = Product.find(params[:id])
    @admin_product.destroy

    redirect_to admin_products_path
  end

  def search
    @@admin_products = @q.result
    @admin_products = @q.result
    render 'index'
  end

  def output
    admin_products = @@admin_products
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_posts_csv(admin_products)
      end
    end
  end

  def changeflag
    @admin_product = Product.find(params[:id])
    
    if @admin_product.published == 0 then
      @admin_product.update(published:1)
    else
      @admin_product.update(published:0)
    end

    redirect_to admin_products_path
  end


  def import
    Product.import(params[:file])
    redirect_to admin_products_path
  end

  

  private

  def product_params
    params.require(:product).permit(:callput, :brand_id, :settlement_date, :closing_date, :exercise_price, :option_premium)
  end

  def set_q 
    @q = Product.ransack(params[:q])
  end

  def set_option
    @brands = Brand.all
  end

  def send_posts_csv(posts)
    csv_data = CSV.generate do |csv|
      column_names = %w(id callput settlement_date  closing_date exercise_price option_premium brand_id)
      csv << column_names
      posts.each do |post|
        column_values = [
          post.id,
          post.callput,
          post.settlement_date,
          post.closing_date,
          post.exercise_price,
          post.option_premium,
          post.brand_id
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "Product.csv")
  end
end
