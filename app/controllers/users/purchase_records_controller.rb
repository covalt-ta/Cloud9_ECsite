class Users::PurchaseRecordsController < Users::ApplicationController
  def show
    @purchase_record_products = current_user.purchase_record_products.preload(:product)
    if params[:start_at] && params[:end_at]
      start_at = Date.parse(params[:start_at])
      end_at = Date.parse(params[:end_at])
      @purchase_record_products = @purchase_record_products.where(created_at: start_at..end_at)
    end
  end
end