require 'test_helper'

class ProContrasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pro_contra = pro_contras(:one)
  end

  test "should get index" do
    get pro_contras_url
    assert_response :success
  end

  test "should get new" do
    get new_pro_contra_url
    assert_response :success
  end

  test "should create pro_contra" do
    assert_difference('ProContra.count') do
      post pro_contras_url, params: { pro_contra: { body: @pro_contra.body, debate_id: @pro_contra.debate_id, dislikes: @pro_contra.dislikes, email: @pro_contra.email, fellowship_id: @pro_contra.fellowship_id, likes: @pro_contra.likes, move: @pro_contra.move, pc: @pro_contra.pc, poll_id: @pro_contra.poll_id, proposal_id: @pro_contra.proposal_id, rating: @pro_contra.rating, reported: @pro_contra.reported, sources: @pro_contra.sources, tag: @pro_contra.tag, user_id: @pro_contra.user_id, vote_id: @pro_contra.vote_id } }
    end

    assert_redirected_to pro_contra_url(ProContra.last)
  end

  test "should show pro_contra" do
    get pro_contra_url(@pro_contra)
    assert_response :success
  end

  test "should get edit" do
    get edit_pro_contra_url(@pro_contra)
    assert_response :success
  end

  test "should update pro_contra" do
    patch pro_contra_url(@pro_contra), params: { pro_contra: { body: @pro_contra.body, debate_id: @pro_contra.debate_id, dislikes: @pro_contra.dislikes, email: @pro_contra.email, fellowship_id: @pro_contra.fellowship_id, likes: @pro_contra.likes, move: @pro_contra.move, pc: @pro_contra.pc, poll_id: @pro_contra.poll_id, proposal_id: @pro_contra.proposal_id, rating: @pro_contra.rating, reported: @pro_contra.reported, sources: @pro_contra.sources, tag: @pro_contra.tag, user_id: @pro_contra.user_id, vote_id: @pro_contra.vote_id } }
    assert_redirected_to pro_contra_url(@pro_contra)
  end

  test "should destroy pro_contra" do
    assert_difference('ProContra.count', -1) do
      delete pro_contra_url(@pro_contra)
    end

    assert_redirected_to pro_contras_url
  end
end
