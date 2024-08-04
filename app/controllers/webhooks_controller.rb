class WebhooksController < ApplicationController

  def receive
    # Log the incoming request body and headers
    Rails.logger.info("Received webhook: #{request.body.read}")
    Rails.logger.info("Headers: #{request.headers.inspect}")

    # You can also render a response to indicate success
    render json: { message: 'Webhook received' }, status: :ok
  end
end
