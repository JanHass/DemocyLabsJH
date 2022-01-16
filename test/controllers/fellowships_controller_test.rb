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
      post fellowships_url, params: { fellowship: { admin_public_show_address: @fellowship.admin_public_show_address, admin_public_show_city: @fellowship.admin_public_show_city, admin_public_show_country: @fellowship.admin_public_show_country, admin_public_show_date_of_birth: @fellowship.admin_public_show_date_of_birth, admin_public_show_full_name: @fellowship.admin_public_show_full_name, admin_public_show_gender: @fellowship.admin_public_show_gender, admin_public_show_phone_number: @fellowship.admin_public_show_phone_number, admin_public_show_state: @fellowship.admin_public_show_state, admin_required_address: @fellowship.admin_required_address, admin_required_city: @fellowship.admin_required_city, admin_required_country: @fellowship.admin_required_country, admin_required_date_of_birth: @fellowship.admin_required_date_of_birth, admin_required_full_name: @fellowship.admin_required_full_name, admin_required_gender: @fellowship.admin_required_gender, admin_required_phone_number: @fellowship.admin_required_phone_number, admin_required_state: @fellowship.admin_required_state, author_id: @fellowship.author_id, clear_name: @fellowship.clear_name, community_id: @fellowship.community_id, created_at: @fellowship.created_at, description: @fellowship.description, email: @fellowship.email, flags_count: @fellowship.flags_count, geozone_id: @fellowship.geozone_id, name: @fellowship.name, organization_id: @fellowship.organization_id, responsible_id: @fellowship.responsible_id, updatet_at: @fellowship.updatet_at, user_id: @fellowship.user_id, user_public_show_address: @fellowship.user_public_show_address, user_public_show_city: @fellowship.user_public_show_city, user_public_show_country: @fellowship.user_public_show_country, user_public_show_date_of_birth: @fellowship.user_public_show_date_of_birth, user_public_show_full_name: @fellowship.user_public_show_full_name, user_public_show_gender: @fellowship.user_public_show_gender, user_public_show_phone_number: @fellowship.user_public_show_phone_number, user_public_show_state: @fellowship.user_public_show_state, user_required_adress: @fellowship.user_required_adress, user_required_city: @fellowship.user_required_city, user_required_country: @fellowship.user_required_country, user_required_date_of_birth: @fellowship.user_required_date_of_birth, user_required_full_name: @fellowship.user_required_full_name, user_required_gender: @fellowship.user_required_gender, user_required_phone_number: @fellowship.user_required_phone_number, user_required_state: @fellowship.user_required_state } }
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
    patch fellowship_url(@fellowship), params: { fellowship: { admin_public_show_address: @fellowship.admin_public_show_address, admin_public_show_city: @fellowship.admin_public_show_city, admin_public_show_country: @fellowship.admin_public_show_country, admin_public_show_date_of_birth: @fellowship.admin_public_show_date_of_birth, admin_public_show_full_name: @fellowship.admin_public_show_full_name, admin_public_show_gender: @fellowship.admin_public_show_gender, admin_public_show_phone_number: @fellowship.admin_public_show_phone_number, admin_public_show_state: @fellowship.admin_public_show_state, admin_required_address: @fellowship.admin_required_address, admin_required_city: @fellowship.admin_required_city, admin_required_country: @fellowship.admin_required_country, admin_required_date_of_birth: @fellowship.admin_required_date_of_birth, admin_required_full_name: @fellowship.admin_required_full_name, admin_required_gender: @fellowship.admin_required_gender, admin_required_phone_number: @fellowship.admin_required_phone_number, admin_required_state: @fellowship.admin_required_state, author_id: @fellowship.author_id, clear_name: @fellowship.clear_name, community_id: @fellowship.community_id, created_at: @fellowship.created_at, description: @fellowship.description, email: @fellowship.email, flags_count: @fellowship.flags_count, geozone_id: @fellowship.geozone_id, name: @fellowship.name, organization_id: @fellowship.organization_id, responsible_id: @fellowship.responsible_id, updatet_at: @fellowship.updatet_at, user_id: @fellowship.user_id, user_public_show_address: @fellowship.user_public_show_address, user_public_show_city: @fellowship.user_public_show_city, user_public_show_country: @fellowship.user_public_show_country, user_public_show_date_of_birth: @fellowship.user_public_show_date_of_birth, user_public_show_full_name: @fellowship.user_public_show_full_name, user_public_show_gender: @fellowship.user_public_show_gender, user_public_show_phone_number: @fellowship.user_public_show_phone_number, user_public_show_state: @fellowship.user_public_show_state, user_required_adress: @fellowship.user_required_adress, user_required_city: @fellowship.user_required_city, user_required_country: @fellowship.user_required_country, user_required_date_of_birth: @fellowship.user_required_date_of_birth, user_required_full_name: @fellowship.user_required_full_name, user_required_gender: @fellowship.user_required_gender, user_required_phone_number: @fellowship.user_required_phone_number, user_required_state: @fellowship.user_required_state } }
    assert_redirected_to fellowship_url(@fellowship)
  end

  test "should destroy fellowship" do
    assert_difference('Fellowship.count', -1) do
      delete fellowship_url(@fellowship)
    end

    assert_redirected_to fellowships_url
  end
end
