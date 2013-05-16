class Subscriber

  def initialize(api_key)
    @mailchimp = Mailchimp::API.new(api_key, timeout: 60)
  end

  def subscribe(list_id, email)
    result = @mailchimp.list_subscribe(:id => list_id,
                              :email_address => email,
                              :send_welcome => false,
                              :double_optin => false)
  end
end
