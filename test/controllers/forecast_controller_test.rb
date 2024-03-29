require "test_helper"

class ForecastControllerTest < ActionDispatch::IntegrationTest
  test 'homepage loads' do
    get root_url
    assert_response :success
  end

  test 'search address' do
    get search_url, params: { address: '151 E Lake Washington Blvd, Seattle, WA 98112' }
    assert_response :success
    assert_select 'table' do
      assert_select 'tr', 3
    end
  end

  test 'search zip code' do
    get search_url, params: { address: '10036' }
    assert_response :success
    assert_select 'table' do
      assert_select 'tr', 3
    end
  end

  test "search bad address" do
    get search_url, params: { address: "this is not an address" }
    assert_redirected_to '/'
    assert_equal "Couldn't find a forecast for that location. Please check the address and try again.", flash[:warning]
  end
end
