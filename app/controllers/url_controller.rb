class UrlController < ApplicationController
  skip_before_action :verify_authenticity_token

  #its the landing page where user lands up for the first time
  def index

  end

  require 'uri'

  #this accepts the params through ajax call and validates the input url
  #if the url is invalid user is prompted to put valid url
  #if the url is valid it passes on the url to ShortUrl model for further action
  def create_short_url
    begin
      long_url = params[:long_url]
      if (long_url =~ /\A#{URI::regexp}\z/).eql? nil
        render :json => {:status => 'failure', :msg => 'Please provide a valid URL'}
      else
        url = ShortUrl.create_short_link(params[:long_url])
        render :json => {:status => 'success', :short_url => url.short_url, :long_url => url.long_url}
      end
    rescue Exception => e
      logger.error { "Error while creating short link. Params: #{params.inspect}, ErrorMessage: #{e.message}" }
      render :json => {:status => 'error', :url => welcome_path}
    end
  end

end