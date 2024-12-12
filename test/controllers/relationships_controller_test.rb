require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "生成はログインが必要" do
    assert_no_difference "Relationship.count" do
      post relationships_path
    end
  end

  test "破棄はログインが必要" do
    assert_no_difference "Relationship.count" do
      delete relationship_path(relationships(:one))
    end
  end
end
