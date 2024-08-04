class PaymentsController < ApplicationController
  require 'httparty'
  before_action :set_payment, only: [:update]

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      notify_third_parties(@payment)
      render json: @payment, status: :created
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @payment.update(payment_params)
      notify_third_parties(@payment)
      render json: @payment, status: :ok
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :note)
  end

  def notify_third_parties(payment)
    # Load the YAML file
    endpoints_config = YAML.load_file(Rails.root.join('config', 'webhook_endpoints.yml'), aliases: true)
    
    # Determine the appropriate endpoints based on the current environment
    environment = Rails.env
    endpoints = endpoints_config[environment] || endpoints_config['default']
  
    Rails.logger.info("Loaded endpoints: #{endpoints.inspect}")
    
    payload = payment.to_json
    signature = OpenSSL::HMAC.hexdigest('SHA256', Rails.application.credentials.secret_key_base, payload)
    
    endpoints.each do |endpoint|
      # Validate endpoint is a valid URL string
      unless endpoint.is_a?(String) && endpoint.match?(/\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/)
        Rails.logger.error("Invalid endpoint URL: #{endpoint}")
        next
      end
      
      Rails.logger.info("Posting to endpoint: #{endpoint}")
      response = HTTParty.post(endpoint, body: payload, headers: { 'X-Signature' => signature, 'Content-Type' => 'application/json' })
      
      Rails.logger.info("Response from #{endpoint}: #{response.body}")
    end
  end
  
end
