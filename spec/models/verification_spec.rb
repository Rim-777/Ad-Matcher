require 'spec_helper'

RSpec.describe Verification, type: :model do
  it {should have_many(:campaigns).dependent(:destroy)}
  it {should have_many(:reports).dependent(:destroy)}
  it {should validate_presence_of(:campaign_list)}

  let!(:verification) {create(:verification)}

  describe 'included moudule' do
    it 'returnes true if module Messageable is included to Verification model' do
      expect(Verification.included_modules.include?(Messageable)).to eq(true)
    end
  end

  describe '#perform!' do
    it 'receives add_campaigns methods for the verification object' do
      expect(verification).to receive(:add_campaigns)
      verification.send(:perform!)
    end

    it 'receives import_ads methods for the verification object' do
      expect(verification).to receive(:import_ads)
      verification.send(:perform!)
    end

    it 'receives add_reports methods for the verification object' do
      expect(verification).to receive(:add_reports)
      verification.send(:perform!)
    end

    it 'receives send_reports methods for the verification object' do
      expect(verification).to receive(:send_reports)
      verification.send(:perform!)
    end
  end

  describe '#add_campaigns' do
    it 'stores campaigns to the db' do
      expect {verification.send(:add_campaigns)}.to change(Campaign, :count).by(4)
    end

    it 'stores campaigns to th db related to the verification object' do
      expect {verification.send(:add_campaigns)}.to change(verification.campaigns, :count).by(4)
    end
  end

  describe '#import_ads' do
    let!(:campaign1) do
      create(:campaign, status: 'deleted', external_reference: '1', self_reference: 12, verification: verification)
    end

    let!(:campaign2) do
      create(:campaign, status: 'paused', external_reference: '2', self_reference: 14, verification: verification)
    end

    let!(:campaign3) do
      create(:campaign, status: 'paused', external_reference: '3', self_reference: 13, verification: verification)
    end


    let(:response_body) do
      {
          "ads" => [
              {'reference' => '1', 'status' => 'enabled', 'description' => 'Description for campaign 1'},
              {'reference' => '2', 'status' => 'disabled', 'description' => 'Description for campaign 2'},
              {'reference' => '3', 'status' => 'enabled', 'description' => 'Description for campaign 3'}
          ]
      }
    end

    let(:service) {double('AdImportService', import_ad_list: response_body)}

    before {allow(AdImportService).to receive(:new).and_return(service)}

    it 'stores ads to the db' do
      expect {verification.send(:import_ads)}.to change(Ad, :count).by(3)
    end

    it 'adds relations between ads and campaigns respectively' do
      verification.send(:import_ads)
      expect(campaign1.external_reference).to eq(response_body['ads'][0]['reference'])
      expect(campaign2.external_reference).to eq(response_body['ads'][1]['reference'])
      expect(campaign3.external_reference).to eq(response_body['ads'][2]['reference'])
    end
  end

  describe '#add_reports' do
    let!(:campaign1) do
      create(:campaign, status: 'deleted', external_reference: '1', self_reference: 12, verification: verification)
    end

    let!(:ad1) do
      create(:ad, status: 'enabled', campaign: campaign1, reference: '1')
    end

    let!(:campaign2) do
      create(:campaign, status: 'paused', external_reference: '2', self_reference: 13, verification: verification)
    end

    let!(:ad2) do
      create(:ad, status: 'disabled', campaign: campaign2, reference: '2')
    end

    let!(:campaign3) do
      create(:campaign, status: 'paused', external_reference: '3', self_reference: 14, verification: verification)
    end

    let!(:ad3) do
      create(:ad, status: 'enabled', campaign: campaign3, reference: '3')
    end

    it 'stores reports in db if the statuses do not match' do
      expect {verification.send(:add_reports)}.to change(Report, :count).by(2)
    end

    it 'stores reports related to the given verification in db if the statuses do not match' do
      expect {verification.send(:add_reports)}.to change(verification.reports, :count).by(2)
    end

    it 'receives report_message methods for the verification object' do
      expect(verification).to receive(:report_message).twice.with(instance_of(Campaign))
      verification.send(:add_reports)
    end

    it 'stores reports related to the given verification in db if the statuses do not match' do
      verification.send(:add_reports)
      expect(verification.reports.first.message).to eq 'campaign id:12 deleted, ad: enabled'
      expect(verification.reports.last.message).to eq 'campaign id:14 paused, ad: enabled'
    end
  end
end