require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select "ul.pagination", count: 2
    User.where(activated: true).paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name, count: 1
      assert_select "a[href=?]", user_path(user), text: "delete", count: user == @admin ? 0 :1
    end
    assert_difference "User.count", -1 do
      delete user_path(@non_admin)
      assert_response :see_other
      assert_redirected_to users_url
    end
  end

  test "index including pagination" do
    log_in_as(@non_admin)
    get users_path
    assert_template "users/index"
    assert_select "ul.pagination", count: 2
    User.where(activated: true).paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name, count: 1
      assert_select "a[href=?]", user_path(user), text: "delete", count: 0
    end
  end
end
