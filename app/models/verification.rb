class Verification < ActiveRecord::Base
  include Messageable
  validates :campaign_list, presence: true
  has_many :campaigns, dependent: :destroy
  has_many :reports, dependent: :destroy

  def perform!
    add_campaigns
    import_ads
    add_reports
    send_reports
  end

  private
  def add_campaigns
    campaign_list.each do |campaign|
      campaigns.create!(
          self_reference: campaign['id'],
          external_reference: campaign['external_reference'],
          status: campaign['status']
      )
    end
  end

  def import_ads
    ad_list = AdImportService.new.import_ad_list
    ad_list['ads'].each do |ad|
      reference = ad['reference']
      Ad.create(
          campaign: campaigns.find_by(external_reference: reference),
          status: ad['status'],
          reference: reference
          )
    end
  end

  def add_reports
    Campaign.joins(:ad).where(verification_id: id).preload(:ad).each do |campaign|
      campaign_int_status = campaign.read_attribute_before_type_cast(:status)
      ad_int_status = campaign.ad.read_attribute_before_type_cast(:status)
      next if campaign_int_status == ad_int_status
      reports.create(message: report_message(campaign))
    end
  end

  def send_reports
    result = reports.as_json(only: :description); destroy;  result
  end
end
