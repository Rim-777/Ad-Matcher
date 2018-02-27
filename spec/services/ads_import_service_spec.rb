require 'spec_helper'

RSpec.describe AdImportService do
  describe '#import_ad_list' do
    let(:response) do
      Typhoeus::Response.new(body:
      "{\"ads\":[{\"reference\":\"1\",\"status\":\"enabled\",\"description\":\"Description for campaign 1\"},
      {\"reference\":\"2\",\"status\":\"disabled\",\"description\":\"Description for campaign 2\"},
      {\"reference\":\"3\",\"status\":\"enabled\",\"description\":\"Description for campaign 3\"}]}")
    end

    let(:client) {double('AdClient', get_ads: response)}
    before {allow(AdClient).to receive(:new).and_return(client)}

    it 'receives the parse methods for the JSON class with response' do
      expect(JSON).to receive(:parse).with(response.body)
      AdImportService.new.send(:import_ad_list)
    end

    it 'receives the get_ads method for the AdClient object' do
      expect(client).to receive(:get_ads).once
      AdImportService.new.send(:import_ad_list)
    end
  end
end
