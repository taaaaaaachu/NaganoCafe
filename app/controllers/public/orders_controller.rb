class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    # @orders = current_customer.cart_items
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.addresses
  end

  def comfirm
  end

  def complete
  end

  def create
    binding.pry
  end

  def index
  end

  def show
  end
end
