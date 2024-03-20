require "test_helper"

class NationalWeatherServiceTest < ActionDispatch::IntegrationTest
  test "finds weather periods for seatac airport" do
    forecast = NationalWeatherService.get_forecast 47.4435, -122.3016
    periods = forecast.dig('properties', 'periods')
    refute_empty periods
  end

  test "raises exception for coordinates outside USA" do
    assert_raises(ArgumentError) { forecast = NationalWeatherService.get_forecast "42", "42" }
  end
end
