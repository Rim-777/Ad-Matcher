module ModelMacros

  def let_campaigns_and_ads
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
  end
end