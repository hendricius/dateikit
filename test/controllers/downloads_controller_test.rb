require 'test_helper'

class DownloadsControllerTest < ActionController::TestCase
  setup do
    @download = downloads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:downloads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create download" do
    assert_difference('Download.count') do
      post :create, download: { allowed_downloads: @download.allowed_downloads, download_count: @download.download_count, expires_at: @download.expires_at, short_url: @download.short_url }
    end

    assert_redirected_to download_path(assigns(:download))
  end

  test "should show download" do
    get :show, id: @download
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @download
    assert_response :success
  end

  test "should update download" do
    patch :update, id: @download, download: { allowed_downloads: @download.allowed_downloads, download_count: @download.download_count, expires_at: @download.expires_at, short_url: @download.short_url }
    assert_redirected_to download_path(assigns(:download))
  end

  test "should destroy download" do
    assert_difference('Download.count', -1) do
      delete :destroy, id: @download
    end

    assert_redirected_to downloads_path
  end
end
