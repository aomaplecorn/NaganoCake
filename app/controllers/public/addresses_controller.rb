class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @addresses = Address.all
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to public_addresses_path
    else
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
    if @address.customer_id == current_customer.id
      render :edit
    else
      redirect_to public_addresses_path
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    if @address.update(address_params)
      redirect_to public_addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.customer_id == current_customer.id
      @address.destroy
      redirect_to public_addresses_path
    else
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end

end
