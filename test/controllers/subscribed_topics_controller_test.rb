require 'test_helper'

class SubscribedTopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subscribed_topics_index_url
    assert_response :success
  end

end
