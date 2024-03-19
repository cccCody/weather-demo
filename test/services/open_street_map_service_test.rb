require "test_helper"

class OpenStreetMapServiceTest < ActionDispatch::IntegrationTest
  test "white house address" do
    location = OpenStreetMapService.get_coords "1600 Pennsylvania Ave NW, Washington, DC 20500"
    assert_equal "20500", location.dig('address', 'postcode')
  end

  test "zip code only" do
    location = OpenStreetMapService.get_coords "10036"
    assert_equal "10036", location.dig('address', 'postcode')
  end

  test "returns nil for a malformed address" do
    location = OpenStreetMapService.get_coords "this is not an address"
    assert_nil location
  end
end
