require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id, followed_id: users(:archer).id)
  end

  test "有効な関係性" do
    assert @relationship.valid?
  end

  test "無効な関係性：フォロワー不足" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "無効な関係性：フォロイー不足" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
