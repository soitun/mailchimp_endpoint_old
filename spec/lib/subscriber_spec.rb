require 'spec_helper'

describe Subscriber do
  subject { Subscriber.new('f38f259b6c14a78f83d80c2c01ecdabc-us5') }

  it 'subscribes email to list' do
    VCR.use_cassette('subscriber_valid') do
      response = subject.subscribe('f167c0d6ca', 'chris+7@spreecommerce.com')
      response.should be_true
    end
  end

  it 'returns errors from mailchimp' do
    VCR.use_cassette('subscriber_invalid') do
      response = subject.subscribe('f167c0d6ca', 'c@XXX')
      response["error"].should eq 'Invalid Email Address: c@XXX'
    end
  end
end
