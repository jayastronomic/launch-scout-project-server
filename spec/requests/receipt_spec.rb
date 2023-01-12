require 'rails_helper'

RSpec.describe ReceiptsController, type: :request do 
  describe 'POST /receipts/process' do 
   let(:receipt_params) {
    { receipt: {
        retailer: "M&M Corner Market",
        purchase_date: "2022-03-20",
        purchase_time: "14:33",
        items: [
          {
            "short_description": "Gatorade",
            "price": "2.25"
          },{
            "short_description": "Gatorade",
            "price": "2.25"
          },{
            "short_description": "Gatorade",
            "price": "2.25"
          },{
            "short_description": "Gatorade",
            "price": "2.25"
          }
        ],
        total: "9.00"
        }
      }
    }
    context "when receipt params are valid" do
      before(:each) do 
        post '/receipts/process', params: receipt_params
      end

      let(:res_obj) { JSON.parse(response.body).deep_symbolize_keys }
    
      it 'creates a new receipt' do
        expect { Receipt.all.length.to change.from(0).to(1) }
      end

      it 'returns a status code of 200' do
        expect(response).to have_http_status(200)
      end

      it "returns a response with the key :id" do
        expect(res_obj.has_key?(:id)).to be(true)
      end
      
      it 'returns a JSON object with id that is a string in uuid format' do
        expect(res_obj[:id].class).to be(String)
        expect(res_obj[:id]).to match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
      end
    end
  end

  describe 'GET /receipts/:id/points' do 
     context "when receipt a receipt is" do
       before(:each) do
        new_receipt = Receipt.new({
            "retailer": "Target",
            "purchase_date": "2022-01-01",
            "purchase_time": "13:01",
            "items": [
              {
                "short_description": "Mountain Dew 12PK",
                "price": "6.49"
              },{
                "short_description": "Emils Cheese Pizza",
                "price": "12.25"
              },{
                "short_description": "Knorr Creamy Chicken",
                "price": "1.26"
              },{
                "short_description": "Doritos Nacho Cheese",
                "price": "3.35"
              },{
                "short_description": "   Klarbrunn 12-PK 12 FL OZ  ",
                "price": "12.00"
              }
            ],
            "total": "35.35"
          }) 
          new_receipt.save!
          get "/receipts/#{new_receipt.id}/points"
       end

       let(:res_obj) { JSON.parse(response.body).deep_symbolize_keys }
 
       it 'returns a status code of 200' do
        expect(response).to have_http_status(200)
       end

       it "returns a response with the key :points" do
        expect(res_obj.has_key?(:points)).to be(true)
       end
       
       it 'returns the points associated with the receipt id passed in the endpoint' do
        expect(res_obj[:points]).to be(28)
       end
     end
   end
end