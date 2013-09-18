require 'viator/middleware'

module Viator
  class Client
    BASE_URL ||= "http://viatorapi.viator.com".freeze
    
    attr_reader :http
    
    def initialize(options = {})
      @options = {
        :api_key => VIATOR_API_KEY
      }.merge(options)
      
      @http = Faraday.new(BASE_URL) do |faraday|
        faraday.use Viator::Middleware::Http, :api_key => @options[:api_key]
        faraday.adapter :net_http
      end
    end
    
    def version
      @http.get "/service/util/version"
    end
    
    def locations
      @http.get "/service/taxonomy/locations"
    end
    
    def closest_destination_id_from_location_name(location)
      closest_distance = nil
      closest_destination_id = nil
      desired_latitude, desired_longitude = Geocoder.coordinates(location)
      
      supported_locations = locations.body.data
      supported_locations.each do |viator_location|
        distance_between = Geocoder::Calculations.distance_between(
          [desired_latitude, desired_longitude], 
          [viator_location.latitude, viator_location.longitude])
        if closest_distance.nil? or distance_between < closest_distance
          closest_distance = distance_between
          closest_destination_id = viator_location.destination_id
        end
      end
      
      closest_destination_id
    rescue
      nil
    end

    def closest_destination_id_from_lat_long(latitude, longitude)
      closest_distance = nil
      closest_destination_id = nil
      
      supported_locations = locations.body.data
      supported_locations.each do |viator_location|
        distance_between = Geocoder::Calculations.distance_between(
          [latitude, longitude], 
          [viator_location.latitude, viator_location.longitude])
        if closest_distance.nil? or distance_between < closest_distance
          closest_distance = distance_between
          closest_destination_id = viator_location.destination_id
        end
      end
      
      closest_destination_id
    rescue
      nil
    end
    
    # @param [Hash] params
    # @option params :start_date - Date or Time (REQUIRED)
    # @option params :end_date - Date or Time (REQUIRED)
    # @option params :dest_id - Fixnum Viator destination ID (REQUIRED)
    # @option params :sort_order - String:
    #     TOP_SELLERS - The top sellers
    #     REVIEW_AVG_RATING_A - Traveler Rating (low -> high) Average
    #     REVIEW_AVG_RATING_D - Traveler Rating (high -> low) Average
    #     PRICE_FROM_A - Price (low -> high)
    #     PRICE_FROM_D - Price (high -> low)
    # @option params :top_x - String results from - to 
    #   (e.g. "1-15", 1st to 15th result)
    # @option params :cat_id - Viator category ID 
    #   (/service/taxonomy/categories)
    # @option params :sub_cat_id - Viator subcategory ID 
    #   (/service/taxonomy/categories)
    # @option params :currency_code - String
    # @return [Faraday::Response] product search results
    def search_products(params = {})
      product_options = {
        :startDate => params[:start_date].to_date.to_formatted_s("%Y-%m-%d"),
        :endDate => params[:end_date].to_date.to_formatted_s("%Y-%m-%d"),
        :destId => params[:dest_id], 
        :sortOrder => params[:sort_order] || "TOP_SELLERS",
        :topX => params[:top_x] || "1-15",
        :catId => params[:cat_id] || 0,
        :subCatId => params[:sub_cat_id] || 0,
        :currencyCode => params[:currency_code] || "USD",
        :dealsOnly => false,
      }
      @http.post do |req|
        req.url '/service/search/products'
        req.headers['Content-Type'] = 'application/json'
        req.body = product_options.to_json
      end
    end
  end
end