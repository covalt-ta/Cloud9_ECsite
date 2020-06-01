class Products::AddToBasketsController < Products::ApplicationController
  
  def create
    basket = current_user.prepare_basket
    product = Product.find(params[:product_id])
    basket.basket_products.create!(product_id: product.id)
    
    redirect_to basket_path
  end
  
end