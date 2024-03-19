require 'net/http'

class NationalWeatherService
    def self.get_forecast(lat, lon)
        pointsUri = URI("https://api.weather.gov/points/#{lat},#{lon}")
        pointsResponse = Net::HTTP.get_response(pointsUri)
        point = JSON.parse(pointsResponse.body)

        forecastUri = URI(point['properties']['forecast'])
        forecastResponse = Net::HTTP.get_response(forecastUri)
        JSON.parse(forecastResponse.body)
        # todo: handle errors
    end
end
