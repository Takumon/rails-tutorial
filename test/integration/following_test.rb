require "test_helper"

class Following < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    log_in_as(@user)
  end
end

class FollowingTest < Following
  test "フォロー一覧" do
    get following_user_path(@user)
    assert_response :success
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "フォロワー一覧" do
    get followers_user_path(@user)
    assert_response :success
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
end

class Unfolow < Following
  def setup
    super
    @user.follow(@other)
    @relationship = @user.active_relationships.find_by(followed_id: @other.id)
  end
end

class UnfolowTest < Unfolow
  test "フォロー解除" do
    assert_difference "@user.following.count", -1 do
      delete relationship_path(@relationship)
    end
    assert_response :see_other
    assert_redirected_to @other
  end
end
