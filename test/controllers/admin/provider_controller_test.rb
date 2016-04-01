require 'test_helper'

class Admin::ProviderControllerTest < ActionController::TestCase


  def setup
    @controller = Admin::ProviderController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  def test_new
    get :new
    assert_template 'admin/provider/new'
    assert_tag 'h1', :content => 'Create new author'
    assert_tag 'form', :attributes => {:action => '/admin/author/create'}
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
