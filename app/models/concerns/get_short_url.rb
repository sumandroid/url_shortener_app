module GetShortUrl
  extend ActiveSupport::Concern


  module ClassMethods
    def generate_short_url
      short_url = 'minulr.herokuapp.com'    #the static part of the shorturl which is pointed to our application
      chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map { |range| range.to_a }.flatten #creates map of 62 chars
      short_url = short_url + '/' + 6.times.map { chars.sample }.join #choose 6 characters randomly and join them which have 62^6 possibilities
      return short_url
    end

    def sanitize_url(long_url)
      original_url = long_url.strip
      sanitized_url = original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, '') #removing the http:, https: and www part from url
      sanitized_url.slice!(-1) if sanitized_url[-1] == '/'
      return "http://#{sanitized_url}"
    end
  end
end