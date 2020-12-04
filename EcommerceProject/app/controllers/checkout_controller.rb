class CheckoutController < ApplicationController
  # POST /checkout/create
  # A product id will be in the params hash: params[:product_id]
  def create
    # Load up the cart the user wishes to purchase from the product models
    if cart.nil?
      redirect_to root_path
      return
    end

    redirect_to new_user_session_path if current_user.nil?

    total_before_tax = 0
    stripe_ready_line_items = []
    cart.each do |item|
      item_amount = (item.keys[0].price * 100).to_i
      total_before_tax += item_amount
      stripe_ready_line_items << {
        name: item.keys[0].name.to_s,
        description: item.keys[0].description.to_s,
        amount: item_amount,
        currency: 'cad',
        quantity: item.values[0]
      }
      # puts item.keys[0].name.to_s + ', quantity: ' + item.values[0].to_s
    end
    # calculate and add gst and pst from province location
    stripe_ready_line_items << {
      name: 'GST',
      description: 'Goods and Service Tax',
      amount: (total_before_tax * 0.05).to_i,
      currency: 'cad',
      quantity: 1
    }
    stripe_ready_line_items << {
      name: 'PST',
      description: 'Provincial Sales Tax',
      amount: (total_before_tax * 0.07).to_i,
      currency: 'cad',
      quantity: 1
    }

    # puts 'check here'
    # puts stripe_ready_line_items

    # Establish a connection with stripe
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: stripe_ready_line_items
    )

    puts @session
    puts 'create intent'
    puts @session.payment_intent
    puts @session.amount_total

    # Establsih a cvonnection with stripe and then redirect ehe user to the payment screen.

    respond_to do |format|
      format.js # render app/views/checkout/checkout.js.erb -- ie embeded ruby in javascript
    end
  end

  def success
    # successfully got customer's money
    # add stripe session_id to orders??
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    puts 'return intent'
    puts @payment_intent.id
    puts @payment_intent.amount_received
    puts @payment_intent.charges.data[0].paid
  end

  def cancel
    # something went wrong
  end

  # CHECKOUT/SHOW
  def index
    if cart.nil?
      redirect_to root_path
      return
    end

    if current_user.nil?
      redirect_to new_user_session_path
      return
    end

    @total_before_tax = 0
    @total_after_tax = 0
    @stripe_ready_line_items = []
    cart.each do |item|
      item_amount = (item.keys[0].price * 100).to_i
      @total_before_tax += item_amount
      @stripe_ready_line_items << {
        name: item.keys[0].name.to_s,
        description: item.keys[0].description.to_s,
        amount: item_amount,
        currency: 'cad',
        quantity: item.values[0]
      }
      # puts item.keys[0].name.to_s + ', quantity: ' + item.values[0].to_s
    end
    # calculate and add gst and pst from province location\

    @province = Province.find(current_user.Province_id)
    # puts province
    gst_amount = (@total_before_tax * @province.GST).to_i
    pst_amount = (@total_before_tax * @province.PST).to_i
    hst_amount = (@total_before_tax * @province.hst).to_i

    @total_after_tax = @total_before_tax + gst_amount + pst_amount + hst_amount
    if gst_amount > 0
      @stripe_ready_line_items << {
        name: 'GST',
        description: 'Goods and Service Tax',
        amount: gst_amount,
        currency: 'cad',
        quantity: 1
      }
    end
    if pst_amount > 0
      @stripe_ready_line_items << {
        name: 'PST',
        description: 'Provincial Sales Tax',
        amount: pst_amount,
        currency: 'cad',
        quantity: 1
      }
    end
    if hst_amount > 0
      @stripe_ready_line_items << {
        name: 'HST',
        description: 'Harmonized Sales Tax',
        amount: hst_amount,
        currency: 'cad',
        quantity: 1
      }
    end

    puts 'test index here'
    puts @province
    puts gst_amount
    puts pst_amount
    puts hst_amount
    puts @total_before_tax
    puts @total_after_tax
  end
end
