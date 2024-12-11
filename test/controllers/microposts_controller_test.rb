require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:orange)
  end

  test "ログインしていない場合に、ポスト生成しようとすると、リダイレクトする" do
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "ログインしていない場合に、ポスト削除しようとすると、リダイレクトする" do
    assert_no_difference "Micropost.count" do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "間違ったポストを削除しようとすると、リダイレクトする" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference "Micropost.count" do
      delete micropost_path(micropost)
    end

    assert_response :see_other
    assert_redirected_to root_url
  end
end