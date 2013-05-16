Dir['./lib/**/*.rb'].each { |f| require f }

class MailChimpEndpoint < EndpointBase

  set :logging, true

  post '/subscribe' do
    mailchimp_list = MailChimpList.new(api_key)
    result = mailchimp_list.subscribe(list_id, email, merge_vars)

    if result[:subscribed]
      process_result 200, merged_response(result)
    else
      process_result 500, merged_response(result)
    end
  end

  private
  def order
    @message[:payload]['order']['actual']
  end

  def email
    order['email']
  end

  def list_id
    @config['mailchimp.list_id']
  end

  def api_key
    @config['mailchimp.api_key']
  end

  def merge_vars
    { 'FNAME' => order['bill_address']['firstname'],
      'LNAME' => order['bill_address']['lastname'] }
  end

  def merged_response(result)
    { 'message_id' => @message[:message_id],
      'email' => email,
      'list_id' => list_id }.merge(result)
  end
end
