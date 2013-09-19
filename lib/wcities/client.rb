require 'wcities/middleware'

module Wcities
  class Client
    BASE_URL ||= "http://dev.wcities.com".freeze
    
    attr_reader :http
    
    def initialize(options = {})
      @options = {
        oauth_token: WCITIES_API_KEY
      }.merge(options)
      
      @http = Faraday.new(BASE_URL) do |faraday|
        faraday.use Wcities::Middleware::Http, :oauth_token => @options[:oauth_token]
        faraday.adapter :net_http
      end
    end
        
    # @param [Hash] params
    # @option params :start_date - Date or Time (REQUIRED)
    # @option params :end_date - Date or Time (REQUIRED)
    # @option params :latitude - latitude (REQUIRED)
    # @option params :longitude - longitude (REQUIRED)
    # @return [Faraday::Response] product search results
    def get_events(params = {})
      product_options = {
        lang: 'en',
        media: 'enable',
        link: 'enable',
        offensive: 'disable',
        lat: params[:latitude],
        lon: params[:longitude],
        start: params[:start_date].to_date.to_formatted_s("%Y-%m-%d"),
        end: params[:end_date].to_date.to_formatted_s("%Y-%m-%d"),
        miles: '100',
        sortBy: 'distance'
      }
      response = @http.get "/V3/event_api/getEvents.php", product_options
      response.body.cityevent
    end
  end
end