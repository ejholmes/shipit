require 'spec_helper'

describe Deployalot, :type => :request do

  it "works" do
    post '/deploy', {}
    last_response.should be_ok
  end

end
