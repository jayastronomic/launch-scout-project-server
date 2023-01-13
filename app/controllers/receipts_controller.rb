
class ReceiptsController < ApplicationController
  before_action :underscore_params, only: [:create]

  def create
    @new_receipt = Receipt.new(receipt_params)
    if @new_receipt.valid?
      if items_valid?
        if prices_eql_total?
          @new_receipt.save!    
          render json: { id: @new_receipt.id }, status: :created
        else
          render json: { error: true, status: 400, description: "The sum of item prices must equal the total"}, status: :bad_request
        end
      else
        render json: { errors: @new_receipt.items, status: 400, description: "The receipt items are invalid"  }, status: :bad_request
      end
    else
      render json: { errors: @new_receipt.errors.full_messages, status: 400, description: "The receipt is invalid"  }, status: :bad_request
    end
  end

  def points
    receipt = Receipt.find(params[:id])
    if !receipt.nil?
      render json: { points: receipt.points }, status: :ok
    else
      render json: { status: 404, description: "Receipt Not Found with ID: '#{params[:id]}'"}, status: :not_found
    end
  end 

  #BONUS ACTION
  def index
    receipts = Receipt.all.map do |receipt|
      { 
        "id" => receipt.id,
        "retailer" =>  receipt.retailer,
        "purchase_date" => receipt.purchase_date,
        "purchase_time" => Time.parse(receipt.purchase_time).strftime("%l:%M%P"),
        "total" =>  receipt.total,
        "items" => receipt.items.map { |item| { "short_description" => item.short_description, "price" => item.price } },
        "points" => receipt.points, 
        "breakdown" => receipt.breakdown
      }.deep_transform_keys! { |key| key.camelize(:lower) }
    end
    render json: receipts, status: :ok
  end

  private

  def items_valid?
    @new_receipt.items.each do |item|
       return false if !item.valid?
    end
    true
  end

  def prices_eql_total?
    @new_receipt.items.sum { |item| item.price.to_f } === @new_receipt.total.to_f
  end

  def underscore_params
    params.deep_transform_keys!(&:underscore)
  end

  def receipt_params
    params.require(:receipt).permit(
      :retailer,
      :purchase_date,
      :purchase_time,
      :total,
      items: [:short_description, :price]
    )
  end
end
