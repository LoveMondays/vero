require 'spec_helper'

describe Vero::Api::Workers::Users::EditAPI do
  subject { Vero::Api::Workers::Users::EditAPI.new('https://api.getvero.com', {}) }
  it "should inherit from Vero::Api::Workers::BaseCaller" do
    expect(subject).to be_a(Vero::Api::Workers::BaseAPI)
  end

  it "should map to current version of Vero API" do
    expect(subject.send(:url)).to eq("https://api.getvero.com/api/v2/users/edit.json")
  end

  subject { Vero::Api::Workers::Users::EditAPI.new('https://api.getvero.com', {:auth_token => 'abcd', :email => 'test@test.com', :changes => { :email => 'test@test.com' }}) }
  describe :validate! do
    it "should not raise an error when the keys are Strings" do
      options = {"auth_token" => 'abcd', "email" => 'test@test.com', "changes" => { "email" => 'test@test.com' }}
      subject.options = options
      expect { subject.send(:validate!) }.to_not raise_error
    end
  end

  describe :request do
    it "should send a request to the Vero API" do
      expect(RestClient).to receive(:put).with("https://api.getvero.com/api/v2/users/edit.json", {:auth_token => 'abcd', :email => 'test@test.com', :changes => { :email => 'test@test.com' }}.to_json, {:content_type => :json, :accept => :json})
      allow(RestClient).to receive(:put).and_return(200)
      subject.send(:request)
    end
  end

  describe "integration test" do
    it "should not raise any errors" do
      allow(RestClient).to receive(:put).and_return(200)
      expect { subject.perform }.to_not raise_error
    end
  end
end