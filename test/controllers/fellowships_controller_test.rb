require 'test_helper'

class FellowshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fellowship = fellowships(:one)
  end

  test "should get index" do
    get fellowships_url
    assert_response :success
  end

  test "should get new" do
    get new_fellowship_url
    assert_response :success
  end

  test "should create fellowship" do
    assert_difference('Fellowship.count') do
      post fellowships_url, params: { fellowship: { author_id: @fellowship.author_id, clear_name: @fellowship.clear_name, community_id: @fellowship.community_id, created_at: @fellowship.created_at, description: @fellowship.description, flags_count: @fellowship.flags_count, geozone_id: @fellowship.geozone_id, id: @fellowship.id, name: @fellowship.name, organization_id: @fellowship.organization_id, responsible_id: @fellowship.responsible_id, updated_at: @fellowship.updated_at } }
    end

    assert_redirected_to fellowship_url(Fellowship.last)
  end

  test "should show fellowship" do
    get fellowship_url(@fellowship)
    assert_response :success
  end

  test "should get edit" do
    get edit_fellowship_url(@fellowship)
    assert_response :success
  end

  test "should update fellowship" do
    patch fellowship_url(@fellowship), params: { fellowship: { author_id: @fellowship.author_id, clear_name: @fellowship.clear_name, community_id: @fellowship.community_id, created_at: @fellowship.created_at, description: @fellowship.description, flags_count: @fellowship.flags_count, geozone_id: @fellowship.geozone_id, id: @fellowship.id, name: @fellowship.name, organization_id: @fellowship.organization_id, responsible_id: @fellowship.responsible_id, updated_at: @fellowship.updated_at } }
    assert_redirected_to fellowship_url(@fellowship)
  end

  test "should destroy fellowship" do
    assert_difference('Fellowship.count', -1) do
      delete fellowship_url(@fellowship)
    end

    assert_redirected_to fellowships_url
  end
end
