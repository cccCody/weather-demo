require 'net/http'

class OpenStreetMapService
    def self.get_coords(address)
        uri = URI("https://nominatim.openstreetmap.org/search?q=#{address}&format=jsonv2&limit=1&countrycodes=us&addressdetails=1")
        response = Net::HTTP.get_response(uri)
        locations = JSON.parse(response.body)
        locations.first
    end
end


