module GetShortUrl
  extend ActiveSupport::Concern


  module ClassMethods
    def generate_short_url
      short_url = 'https://minurl'
      chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map { |range| range.to_a }.flatten
      short_url = short_url + '/' + 6.times.map { chars.sample }.join
      return short_url
    end

    def sanitize_url(long_url)
      original_url = long_url.strip
      sanitized_url = original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
      sanitized_url.slice!(-1) if sanitized_url[-1] == '/'
      return "http://#{sanitized_url}"
    end
  end
end