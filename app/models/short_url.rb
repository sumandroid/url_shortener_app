class ShortUrl < ApplicationRecord

  include GetShortUrl

  #takes the long url as parameter and calls concern methods to first sanitize and then check if the url exists or not
  #if the url exists it lookup for the short url in db
  #if it does not exists it creates new entry in db
  def self.create_short_link(long_url)
    sanitized_url = sanitize_url(long_url)
    duplicate_url = self.find_by_long_url(sanitized_url)
    if duplicate_url.present?
      number_of_hits = duplicate_url.number_of_hits.to_i
      duplicate_url.number_of_hits = number_of_hits + 1
      duplicate_url.save
      return duplicate_url
    else
      short_url = generate_short_url
      short_url_object = self.new({
                                   :long_url => sanitized_url,
                                   :short_url => short_url,
                                   :number_of_hits => 1
                                  })
      short_url_object.save
      return short_url_object
    end
  end
end
