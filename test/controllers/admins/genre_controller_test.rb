require "test_helper"

class Admins::GenreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_genre_index_url
    assert_response :success
  end

  test "should get edit" do
    get admins_genre_edit_url
    assert_response :success
  end
end
