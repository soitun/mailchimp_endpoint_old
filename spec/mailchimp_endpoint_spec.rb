require 'spec_helper'

describe MailChimpEndpoint do
  let(:config) { [{ 'name' => 'mailchimp.api_key', 'value' => 'abc123' },
                  { 'name' => 'mailchimp.list_id', 'value' => 'f167c0d6ca' }] }

  let(:message) {{ 'store_id' => '123229227575e4645c000001',
                   'message_id' => 'abc',
                   'payload' => { 'order' => { 'actual' => Factories.order },
                                  'parameters' => config } }}

  def auth
    {'HTTP_X_AUGURY_TOKEN' => 'x123', "CONTENT_TYPE" => "application/json"}
  end

  def app
    MailChimpEndpoint
  end

  before do
   @mailchimp_list = double
   MailChimpList.should_receive(:new).with('abc123').and_return(@mailchimp_list)
  end

 it 'subscribes new users to a mailing list' do
   @mailchimp_list.should_receive(:subscribe)
                  .with('f167c0d6ca', 'andrew@spreecommerce.com', hash_including('FNAME' => 'Andrew'))
                  .and_return({ :subscribed => true })

   post '/subscribe', message.to_json, auth

   last_response.status.should == 200
   last_response.should match /andrew@spreecommerce\.com/
 end

 it 'creates an event if subscription failed' do
   @mailchimp_list.should_receive(:subscribe)
                  .with('f167c0d6ca', 'andrew@spreecommerce.com', hash_including('FNAME' => 'Andrew'))
                  .and_return({"error"=>"Invalid Email Address: c@XXX", "code"=>502})

   post '/subscribe', message.to_json, auth

   last_response.status.should == 500
   last_response.should match /Invalid Email Address/
 end
end
