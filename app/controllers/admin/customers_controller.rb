class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    if @customer.is_deleted == true
      @status = "退会"
    else
      @status = "有効"
    end
  end

  def edit
  end

  def update
  end
end
