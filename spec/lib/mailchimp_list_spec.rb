require 'spec_helper'

describe MailChimpList do
  subject { MailChimpList.new('f38f259b6c14a78f83d80c2c01ecdabc-us5') }

  it 'subscribes email to list' do
    VCR.use_cassette('mailchimp_list_subscribe_valid') do
      merge_vars = { 'FNAME' => 'Fox', 'LNAME' => 'Mulder' }
      response = subject.subscribe('f167c0d6ca', 'chris+8@spreecommerce.com', merge_vars)
      response[:subscribed].should be_true
    end
  end

  it 'returns errors from mailchimp' do
    VCR.use_cassette('mailchimp_list_subscribe_invalid') do
      response = subject.subscribe('f167c0d6ca', 'c@XXX')
      response["error"].should eq 'Invalid Email Address: c@XXX'
    end
  end
end
