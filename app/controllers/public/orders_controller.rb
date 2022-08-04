class Public::OrdersController < ApplicationController
  
  
  def new
    @order = Order.new
    # @orders = current_customer.cart_items
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.addresses
  end

  def comfirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else


    end


  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    # binding.pry
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.amount = cart_item.amount
      @order_details.item_id = cart_item.item_id
      @order_details.order_id = @order.id
      @order_details.price = cart_item.item.price
      @order_details.making_status = 1
      @order_details.save
    end
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment)
    end

end
