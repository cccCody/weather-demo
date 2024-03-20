class ForecastController < ApplicationController
    def index
        flash.each do |type, msg|
            puts "#{type}, #{msg}"
        end
    end

    def search
        @address = params[:address]

        begin
            location = OpenStreetMapService.get_coords @address
            raise ArgumentError.new "Couldn't find a forecast for that location. Please check the address and try again." unless location

            logger.debug "location: #{JSON.pretty_generate(location)}"

            @display_name = location.dig('display_name')
            zip_code = location.dig('address', 'postcode')
            @lat = location.dig('lat').to_f.round(4)
            @lon = location.dig('lon').to_f.round(4)

            logger.debug "interpreting address as: #{@display_name} (#{@lat}, #{@lon})"

            forecast = Rails.cache.read(zip_code)
            if forecast
                logger.debug "using cached results for #{zip_code}"
                @from_cache = true
            else
                forecast = NationalWeatherService.get_forecast(@lat, @lon)
                Rails.cache.write(zip_code, forecast, expires_in: 30.minutes)
                logger.debug "caching forecast for #{zip_code}"
            end

            @periods = forecast.dig('properties', 'periods').first(12)
            logger.debug "periods: #{JSON.pretty_generate(@periods)}"
    
            render 'search'
            return
        rescue ArgumentError => err
            flash[:warning] = err.message
            redirect_to '/'
        end

    end
end
