class AdminProductsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
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

  def product_params
    params.require(:product).permit(:callput, :brand_id, :settlement_date, :closing_date, :exercise_price, :option_premium)
  end
end
