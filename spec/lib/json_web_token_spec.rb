require 'rails_helper'

describe JsonWebToken do
  
  let(:token) { JsonWebToken.encode({user_id: 1}) }

  it 'should verify token' do
    payload = JsonWebToken.decode(token)
    expect(payload[:user_id]).to eq(1)
  end

  it "should return nil" do
    payload = JsonWebToken.decode('sadf')
    expect(payload).to eq(nil)
  end
end