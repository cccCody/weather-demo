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

        forecastUri = URI(point['properties']['forecast'])
        forecastResponse = Net::HTTP.get_response(forecastUri)
        JSON.parse(forecastResponse.body)
    end
end
