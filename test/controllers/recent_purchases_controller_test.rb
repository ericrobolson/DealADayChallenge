require 'test_helper'

class RecentPurchasesControllerTestControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase = purchases(:one)
  end

  test "should get index" do
    get recent_purchases_url
    assert_response :success
  end
end
