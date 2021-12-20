require 'test_helper'

class ScrapingTicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scraping_tickets_index_url
    assert_response :success
  end

end
