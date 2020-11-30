class CheckoutController < ApplicationController
  def create
    # Establsih a cvonnection with stripe and then redirect ehe user to the payment screen.
  end

  def success
    # successfully got customer's money
  end

  def cancel
    # something went wrong
  end
end
