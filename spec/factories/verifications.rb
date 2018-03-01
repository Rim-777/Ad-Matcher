FactoryBot.define do
  factory :verification do
    campaign_list [
                      {id: 12, status: "deleted", external_reference: "1"},
                      {id: 14, status: "paused", external_reference: "2"},
                      {id: 13, status: "paused", external_reference: "3"},
                      {id: 14, status: "paused", external_reference: "10"}
                  ]
  end
end

