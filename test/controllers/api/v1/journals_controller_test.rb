# coding: utf-8
require 'test_helper'

class Api::V1::JournalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    @user = users(:one)
    get "/api/v1/journals", params: {token: @user.token}
    assert_response :success
  end
  test "should post create" do
    # success
    @user = users(:one)
    post "/api/v1/journals", params: {name: "うんち代", amount: 20000,
                                      target_datetime: "2020-04-01",
                                      type: "income", token: @user.token}
    assert_response :success
    @j = Journal.find_by(name: "うんち代")
    assert @j
    assert Income.find_by(journal_id: @j.id)
    # success
    post "/api/v1/journals", params: {name: "うんこっこ", amount: 10000,
                                      target_datetime: "2020-04-01",
                                      type: "expene", token: @user.token}
    @j = Journal.find_by(name: "うんこっこ")
    assert @j
    assert Expene.find_by(journal_id: @j.id)
    assert_response :success

  end
  test "should delete destroy" do
    @j = Journal.all.first
    @jid = @j.id
    @user = User.find(@j.user_id)
    assert Journal.find(@jid)
    delete "/api/v1/journals/#{@jid}/?token=#{@user.token}"
    assert_response :success
    assert Journal.all.map(&:id).select{|id| id == @jid}.size.zero?
  end
end
