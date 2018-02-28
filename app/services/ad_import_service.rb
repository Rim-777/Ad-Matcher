class AdImportService
  def import_ad_list
    response = AdClient.new.get_ads
    JSON.parse(response.body)
  end
end
