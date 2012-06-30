require "spec_helper"

describe Shipit do
  include Rack::Test::Methods

  describe "GET '/'" do
    before do
      get '/'
    end

    specify { last_response.should be_ok }
  end

  describe "POST '/setup'" do
    before do
      post '/setup', post_data
    end

    context "with valid" do
      let(:post_data) do
        { :repo => "ejholmes/shipit", :name => "shipit" }
      end

      specify { last_response.should be_ok }

      describe "the created repository" do
        subject { Shipit::Repository.last }

        it { should be_valid }
        its(:name) { should eq 'shipit' }
        its(:uri)  { should eq 'git@github.com:ejholmes/shipit' }
      end
    end
  end
end
