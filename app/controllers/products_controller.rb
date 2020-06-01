class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: "作成に成功"
    else
      flash[:error] = "作成に失敗"
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @current_user = current_user
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :unit, :image)
  end
  
end
