class MailChimpList

  def initialize(api_key)
    @mailchimp = Mailchimp::API.new(api_key, timeout: 60)
  end

  def subscribe(list_id, email, merge_vars={})
    result = @mailchimp.list_subscribe(:id => list_id,
                              :email_address => email,
                              :merge_vars => merge_vars,
                              :send_welcome => false,
                              :double_optin => false)
    if result == true
      { :subscribed => true, :list_id => list_id, :email => email }
    else
      result
    end
  end
end
