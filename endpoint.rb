Dir['./lib/**/*.rb'].each { |f| require f }

class MailChimpEndpoint < EndpointBase

  set :logging, true

  post '/subscribe' do

    puts @message
    puts @config
    process_result 200, {:test => 1}
  end

  # post '/order_cancellation' do
  #   order = OrderCancellation.new(@message[:payload], @message[:message_id], @config)
  #   process_result *order.consume
  # end
end
