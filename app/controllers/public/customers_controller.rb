class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def check
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    if @customer.update(is_deleted: true)
      reset_session
      redirect_to "/"
    else
      render :check
    end
  end

  private

  def customers_params
    params.require(:customer).permit(:email, :last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:is_deleted)
  end
end
