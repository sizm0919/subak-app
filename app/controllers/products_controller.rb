class ProductsController < ApplicationController
  layout 'products'

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add
    if request.post? then
      Product.create(product_params)
      goback
    else
      @product = Product.new
    end
  end

  def edit
    @product = Product.find(params[:id])
    if request.patch? then
      @product.update(product_params)
      goback
    end
  end

  def delete
    Product.find(params[:id]).destroy
    goback
  end

  private
  def product_params
    params.require(:product).permit(:callput, :brand_id, :settlement_date, :closing_date, :exercise_price, :option_premium)
  end

  def goback
    redirect_to '/products'
  end

end