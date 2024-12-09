require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid submit should not register to database" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: {
        name: "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.alert.alert-danger"
  end

  test "valid submit should register to database" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: {
        name: "Takumon",
        email: "user@gmail.com",
        password: "foobar",
        password_confirmation: "foobar" } }
    end

    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    assert_equal "Welcome to the Sample App!", flash[:success]

    assert is_logged_in?
  end
end
