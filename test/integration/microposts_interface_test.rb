require "test_helper"

class MicropostsInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
end

class MicropostsInterfaceTest < MicropostsInterface
  test "ポスト一覧でページングする" do
    get root_path
    assert_select "ul.pagination"
  end

  test "無効なポスト作成リクエストの場合は、エラーメッセージを表示する" do
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select "div#error_explanation"
    assert_select "a[href=?]", "/?page=2"
  end

  test "有効なポスト作成リクエストの場合は、ポストを生成する" do
    content = "ZZZZZZZZZZZ33333333333333FFFFFFFFFFFFF"
    assert_difference "Micropost.count", 1 do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
  end

  test "自身のプロフィールページでは、ポストの削除リンクが表示される" do
    get user_path(@user)
    assert_select "a", text: "delete"
  end

  test "自身のポストを削除できる" do
    m = @user.microposts.paginate(page: 1).first
    assert_difference "Micropost.count", -1 do
      delete micropost_path(m)
    end
  end

  test "他人のプロフィールページでは、ポストの削除リンクが表示されない" do
    get user_path(users(:archer))
    assert_select "a", text: "delete", count: 0
  end
end

class MicropostSidebarTest < MicropostsInterface
  test "サイドバーに投稿数を表示する" do
    get root_path
    assert_match "#{34} micropost", response.body
  end

  test "サイドバーに投稿数を表示する。0件の場合" do
    log_in_as(users(:melory))
    get root_path
    assert_match "0 microposts", response.body
  end

  test "サイドバーに投稿数を表示する。1件の場合" do
    log_in_as(users(:lana))
    get root_path
    assert_match "1 micropost", response.body
  end
end

class ImageUploadTest < MicropostsInterface
  test "画像用のフォームが表示される" do
    get root_path
    assert_select "input[type=file]"
  end

  test "画像をアップロードする" do
    c = "画像付きの投稿です！"
    i = fixture_file_upload("kitten.jpg", "image/jpeg")
    post microposts_path, params: { micropost: { content: c, image: i } }
    assert @user.microposts.first.image.attached?
  end
end
