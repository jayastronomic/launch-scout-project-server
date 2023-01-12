class ReceiptsController < ApplicationController
  def create
    new_receipt = Receipt.new(receipt_params)
    if new_receipt.valid?
      new_receipt.save!
      render json: { id: new_receipt.id }
    else
      render json: { errors: new_receipt.errors.full_messages }
    end
  end

  def points
    receipt = Receipt.find(params[:id])
    if !receipt.nil?
      render json: { points: receipt.points }
    else
      render json: { error: "Receipt Not Found with ID: '#{params[:id]}'" }
    end
  end 

  #BONUS ACTION
  def index
    receipts = Receipt.all.map do |receipt|
      { 
        id: receipt.id,
        retailer: receipt.retailer,
        purchase_date: receipt.purchase_date,
        purchase_time: Time.parse(receipt.purchase_time).strftime("%l:%M%P"),
        total: receipt.total,
        items: receipt.items,
        points: receipt.points, 
        breakdown: receipt.breakdown
      }
    end
    render json: receipts
  end

  private

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
