require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get post_index" do
    get index_post_index_url
    assert_response :success
  end

end
