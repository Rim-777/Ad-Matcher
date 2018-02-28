require 'spec_helper'

describe Api::V1::Verifications, type: :api do

  describe '/verify' do
    context 'POST /api/v1/verify' do
      context 'the proper params are given' do
        let(:params) {
          {
              campaign_list: [
                  {'id' => '12', 'status' => "deleted", 'external_reference' => "1"},
                  {'id' => '14', 'status' => "paused", 'external_reference' => "2"},
                  {'id' => '13', 'status' => "paused", 'external_reference' => "3"},
                  {'id' => "15", 'status' => "paused", 'external_reference' => "10"}
              ]
          }
        }

        let(:expected_response_body) do
          [
              {"message" => "campaign id:12 deleted, ad: enabled"},
              {"message" => "campaign id:13 paused, ad: enabled"}
          ]
        end

        let(:verification) {double('AdImportService', import_ad_list: response_body)}

        it_behaves_like 'ContentType'

        it 'returns 201 status' do
          expect(call_api(params).status).to eq(201)
        end

        it 'receives the create! method for the Verification class with params' do
          expect(Verification).to receive(:create!).once.with(params).and_call_original
          call_api(params)
        end

        it 'returns 201 status' do
          expect(JSON.parse(call_api(params).body)).to eq expected_response_body
        end
      end

      context 'the params are blank' do
        let(:params) {''}

        it_behaves_like 'ContentType'

        it 'returns 400 status' do
          expect(call_api(params).status).to eq(400)
        end

        it 'returns an error' do
          expect(JSON.parse(call_api(params).body)).to eq({'error' => 'campaign_list is missing'})
        end

        it 'does not receive the create! method for the Verification class' do
          expect(Verification).to_not receive(:create!)
          call_api(params)
        end
      end
    end
  end
end
