require 'test_helper'

class CandidatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @candidate = candidates(:one)
  end

  test "should get index" do
    get candidates_url, as: :json
    assert_response :success
  end

  test "should create candidate" do
    assert_difference('Candidate.count') do
      post candidates_url, params: {candidate: {name: 'test test',
                                                years_exp: 15,
                                                status: 'pending',
                                                date_applied: '2018-05-05 11:55:42',
                                                reviewed: false,
                                                description: ''}}, as: :json
    end

    assert_response 201
  end

  test "should show candidate" do
    get candidate_url(@candidate), as: :json
    assert_response :success
  end

  test "should update candidate" do
    patch candidate_url(@candidate), params: {candidate: {
        name: 'test test2',
        status: 'accepted'
    }}, as: :json
    assert_response 200
  end

  test "should destroy candidate" do
    assert_difference('Candidate.count', -1) do
      delete candidate_url(@candidate), as: :json
    end

    assert_response 204
  end
end
