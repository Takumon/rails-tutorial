require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with valid email/invalid password" do
    get login_path
    assert_template "sessions/new"

    post login_path, params: { session: { email: @user.email, password: "invalid" } }
    assert_not is_logged_in?
    assert_template "sessions/new"
    assert_not flash.empty?
    assert_select "div.alert-danger"
    assert_equal "Invalid email/password combination", flash[:danger]

    get signup_path
    assert_template "users/new"
    assert flash.empty?
  end

  test "login with valid infromation followed by logout" do
    get login_path
    assert_template "sessions/new"

    post login_path, params: { session: { email: @user.email, password: "password" } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"

    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url

    # 2番目のウインドウでログイアウトをクリックする操作をシニュレート
    delete logout_path

    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  # ログインしてない状態でログアウト
  test "should stil work after logout in second window" do
    delete logout_path
    assert_redirected_to root_url
  end
end


class RememberingTest < UsersLoginTest
  test "login with remembering" do
    log_in_as(@user, remember_me: "1")
    assert_not cookies[:remember_token].empty?
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: "1")
    log_in_as(@user, remember_me: "0")
    assert cookies[:remember_token].empty?
  end
end
