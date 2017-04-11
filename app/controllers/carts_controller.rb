class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "Successfully added #{item.title} to your cart"
    redirect_to(request.referer)
  end


  def show
    @cart = Cart.new(session[:cart])
    @order_items = @cart.list
  end

  def remove
    @item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.remove_item(params[:item_id])
    @cart.contents.delete_if { |k, v| v == 0 }

    flash[:success] = "Successfully removed <a href='/item/#{@item.id}' > #{@item.title}</a> from your cart.".html_safe
    redirect_to cart_path
  end

  def update
    @cart.update(params[:item_id], params[:cart][:quantity])
    redirect_to cart_path
  end

end
