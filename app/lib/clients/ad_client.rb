class AdClient
  URL = "http://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df"

  def get_ads
    Typhoeus.get(URL)
  end
end
