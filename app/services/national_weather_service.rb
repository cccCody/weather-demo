require 'net/http'

class NationalWeatherService
    def self.get_forecast(lat, lon)
        pointsUri = URI("https://api.weather.gov/points/#{lat},#{lon}")
        pointsResponse = Net::HTTP.get_response(pointsUri)
        point = JSON.parse(pointsResponse.body)
        if pointsResponse.code_type == Net::HTTPNotFound
            Rails.logger.debug "NWS query failed for (#{lat}, #{lon})"
            raise ArgumentError.new "Couldn't find forecast for (#{lat}, #{lon})"
        end

        forecastUri = URI(point.dig('properties', 'forecast'))
        Rails.logger.debug "forecastUri: #{forecastUri}"
        forecastResponse = Net::HTTP.get_response(forecastUri)
        result = JSON.parse(forecastResponse.body)
        if result['status'] == 503
            raise ArgumentError.new "Error from National Weather Service: #{result['detail']}"
        end
        result
    end
end
