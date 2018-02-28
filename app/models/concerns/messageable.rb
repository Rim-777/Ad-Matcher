module Messageable
  extend ActiveSupport::Concern
  included do

    def report_message(campaign)
      "campaign id:#{campaign.self_reference} #{campaign.status}, ad: #{campaign.ad.status}"
    end
  end
end
