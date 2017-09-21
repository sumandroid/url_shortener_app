class ShortUrl < ApplicationRecord

  include GetShortUrl

  def self.create_short_link(long_url)
    sanitized_url = sanitize_url(long_url)
    duplicate_url = self.find_by_long_url(sanitized_url)
    if duplicate_url.present?
      return duplicate_url
    else
      short_url = generate_short_url
      short_url_object = self.new({
                                   :long_url => sanitized_url,
                                   :short_url => short_url
                                  })
      short_url_object.save
      return short_url_object
    end
  end
end
