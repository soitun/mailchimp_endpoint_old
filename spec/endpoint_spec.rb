require 'spec_helper'

describe MailChimpEndpoint do

  let(:message) {{ 'store_id' => '123229227575e4645c000001',
                         'payload' => { 'email' => 'test@example.com',
                                        'order' => {
                                          'actual' => '' }},
                                        'message_id' => 'abc' }}

  def auth
    {'HTTP_X_AUGURY_TOKEN' => 'x123', "CONTENT_TYPE" => "application/json"}
  end

  def app
    MailChimpEndpoint
  end

 it 'subscribes new users to a mailing list' do
   message['payload']['parameters'] = [{ 'name' => 'mailchimp.api_key', 'value' => 'abc123' },
                                       { 'name' => 'mailchimp.list', 'value' => 'Augury Endpoint Test' }]
   response = post '/subscribe', message.to_json, auth
   puts response
 end
end
