require 'rails_helper'

describe PostsHelper do
  describe '#get_host' do
    it 'returns host of the url' do
      expect(get_host("http://wi-wi.herokuapp.com/")).to eq("wi-wi.herokuapp.com")
    end

    it "doesn't return a url without changes" do
      url = generate(:http_url)
      expect(get_host(url)).not_to eq(url)
    end
  end
end
