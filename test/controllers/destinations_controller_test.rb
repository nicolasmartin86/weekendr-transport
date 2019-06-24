require 'test_helper'

class DestinationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get destinations_index_url
    assert_response :success
  end

end
