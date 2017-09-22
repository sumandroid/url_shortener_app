class UrlController < ApplicationController
  skip_before_action :verify_authenticity_token

  #its the landing page where user lands up for the first time
  def index
    @trending_urls = ShortUrl.all.order(number_of_hits: :desc).limit(100)  #get the data from short_urls table in descending order of their number of hits
  end

  require 'uri'

  #this accepts the params through ajax call and validates the input url
  #if the url is invalid user is prompted to put valid url
  #if the url is valid it passes on the url to ShortUrl model for further action
  def create_short_url
    begin
      long_url = params[:long_url]
      if (long_url =~ /\A#{URI::regexp}\z/).eql? nil #checking the url validity with URI regex, if it is valid it returns zero otherwise nil
        render :json => {:status => 'failure', :msg => 'Please provide a valid URL'}
      else
        url = ShortUrl.create_short_link(params[:long_url])
        render :json => {:status => 'success', :short_url => url.short_url, :long_url => url.long_url}
      end
    rescue Exception => e
      logger.error { "Error while creating short link. Params: #{params.inspect}, ErrorMessage: #{e.message}" }
      render :json => {:status => 'error', :url => index_path}
    end
  end


  #it redirects all the short urls to their original urls
  def redirect
    begin
      short_url = request.url.gsub(/(https?:\/\/)|(www\.)/, '') #remove the https:,http: and www part from the url
      original_link = ShortUrl.find_by_short_url!(short_url)
      redirect_to original_link.long_url
    rescue Exception => e
      logger.error { "Error while redirecting to the original link. Params: #{params.inspect}, ErrorMessage: #{e.message}" }
      redirect_to index_path
    end
  end

end