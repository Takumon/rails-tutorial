require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a"*244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept vallid addresses" do
    %w[user@example.com
      USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp
      alice+bob@baz.cn].each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    %w[
      user@example,com
      user_at_foo.org
      user.name@example
      foo@bar_baz.com
      foo@bar+baz.com].each do |address|
        @user.email = address
        assert @user.invalid?, "#{address.inspect} should be invalid"
      end
  end

  test "email addresses should be unique" do
    dup = @user.dup
    @user.save
    assert_not dup.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = " " * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, "")
  end

  test "ユーザー削除時に紐づいた投稿が削除される" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end

  test "ユーザーのフォロー/アンフォローができる" do
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.following?(archer)

    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)

    michael.unfollow(archer)
    assert_not michael.following?(archer)
    assert_not archer.followers.include?(michael)

    michael.unfollow(michael)
    assert_not michael.following?(michael)
  end
end
