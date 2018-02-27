require 'spec_helper'

RSpec.describe 'AdClient' do
  describe '#get_ads' do
    let(:url) {'http://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'}

    it 'receives get method for Typhoeus class' do
      expect(Typhoeus).to receive(:get).with(url)
      AdClient.new.get_ads
    end
  end
end
