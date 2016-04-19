class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    puts "TO: #{@order.to.name}    FROM: #{@order.from.name}"

    respond_to do |format|
      if @order.save
        @order.orderables.each do |orderable|
          update_stock(orderable.item, orderable.quantity, @order.from, @order.to)
        end
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_stock(item, quantity, from, to, revert = false)
    from_stock = from.item_stocks.find_by(item: item)
    to_stock = to.item_stocks.find_by(item: item)

    if revert
      quantity = -1 * quantity
    end

    # Update stock taken from
    if from_stock
      from_stock.quantity = from_stock.quantity - quantity
      puts "#{quantity} #{item.model} taken from #{from.name}"
    else
      from_stock = ItemStock.new({"location_id"=>from.id, "item_id"=>item.id, "quantity"=>-quantity})
      puts "#{quantity} #{item.model} created and taken from #{from.name}"
    end

    # Update stock put in
    if to_stock
      to_stock.quantity = to_stock.quantity + quantity
      puts "#{quantity} #{item.model} put in #{to.name}"
    else
      to_stock = ItemStock.new({"location_id"=>to.id, "item_id"=>item.id, "quantity"=>quantity})
      puts "#{quantity} #{item.model} created and put in #{to.name}"
    end

    if from_stock.save
      puts "From Stock successfully saved"
    else
      puts from_stock.errors
    end

    if to_stock.save
      puts "To Stock successfully saved"
    else
      puts to_stock.errors
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order.orderables.each do |orderable|
      update_stock(orderable.item, orderable.quantity, @order.from, @order.to, true)
    end
    respond_to do |format|
      if @order.update(order_params)
         @order.orderables.each do |orderable|
          update_stock(orderable.item, orderable.quantity, @order.from, @order.to)
        end
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.orderables.each do |orderable|
      update_stock(orderable.item, orderable.quantity, @order.from, @order.to, true)
    end
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:from_location, :to_location, :details, orderables_attributes: [:id, :item_id, :quantity, :_destroy])
    end
end
