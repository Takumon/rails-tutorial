require "test_helper"

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: {
      name: "",
      email: "foo@invalid",
      password: "foo",
      password_confirmation: "bar"
    } }

    assert_template "users/edit"
    assert_select "div.alert-danger", "The form contains 4 errors."
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    patch user_path(@user), params: { user: {
      name: "Updated Name",
      email: "updated-email@gmail.com",
      password: "",
      password_confirmation: ""
    } }

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "Updated Name", @user.name
    assert_equal "updated-email@gmail.com", @user.email
  end

  test "friendly forwarding only forwards the first time" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)

    log_in_as(@user)
    assert_redirected_to user_url(@user)
  end
end
