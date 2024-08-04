require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) { { amount: 100, description: 'Test Payment', note: 'Some note' } }
    let(:invalid_attributes) { { amount: nil, description: 'Test Payment', note: nil } }

    context 'with valid attributes' do
      it 'creates a new payment' do
        expect {
          post :create, params: { payment: valid_attributes }
        }.to change(Payment, :count).by(1)
      end

      it 'notifies third parties' do
        expect(controller).to receive(:notify_third_parties)
        post :create, params: { payment: valid_attributes }
      end

      it 'renders the created payment as JSON' do
        post :create, params: { payment: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['amount']).to eq(100)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new payment' do
        expect {
          post :create, params: { payment: invalid_attributes }
        }.not_to change(Payment, :count)
      end

      it 'renders errors as JSON' do
        post :create, params: { payment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include('amount', 'note')
      end
    end
  end
end
