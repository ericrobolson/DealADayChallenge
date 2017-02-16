require 'test_helper'

class FileUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @file_upload = file_uploads(:one)
  end

  test "should get new" do
    get new_file_upload_url
    assert_response :success
  end

  test "should succesfully redirect after import" do
    post file_uploads_url, params: { file_upload: {file_path: fixture_file_upload('test/fixtures/files/valid_csv.csv')}}
  
    assert_redirected_to '/recent_purchases'
  end

  test "should not redirect after invalid import" do
    post file_uploads_url, params: { file_upload: {file_path: fixture_file_upload('test/fixtures/files/invalid_csv_invalid_item_price.csv')}}

    # Should assert that it doesn't redirect, but stays on the same page and displays any errors    
    assert_response :success
  end

  test "should fail to create with no file" do
    post file_uploads_url
    
    # Should assert that it doesn't redirect, but stays on the same page and displays any errors
    assert_response :success
  end  
end