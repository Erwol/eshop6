require 'test_helper'

class Admin::ProviderControllerTest < ActionController::TestCase
  fixtures :providers

  test "new" do
    get :new
    assert_template 'admin/provider/new'
    assert_tag 'h1', :content => 'Añadir un nuevo proveedor'
    assert_tag 'form', :attributes => { :action => '/admin/provider/create' }
  end

  test "create" do
    get :new
    assert_template 'admin/provider/new'
    assert_difference(Provider, :count) do
      post :create, :provider => {:name => 'Pryca', :telephone => 956214584}
      assert_response :redirect
      assert_redirected_to :action => 'index'
    end
    assert_equal 'El proveedor Pryca fue añadido correctamente.', flash[:notice]
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag :tag => 'input', :attributes => { :name => 'provider[name]', :value => 'Juan' }
    assert_tag :tag => 'input', :attributes => { :name => 'provider[telephone]', :value => '654324567' }
  end

  test "update" do
    post :update, :id => 1, :provider => { :name => 'Empresa A', :telephone => 958652341 }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Empresa A', Provider.find(1).name
  end

  test "test_destroy" do
    assert_difference(Provider, :count, -1) do
      post :destroy, :id => 1
      assert_equal flash[:notice], 'El proveedor Juan fue eliminado correctamente.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_tag :tag => 'div', :attributes => {:id => 'notice'},
                 :content => 'El proveedor Juan fue eliminado correctamente.'
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/provider/show'
    assert_equal 'Juan', assigns(:provider).name
    assert_equal 654324567, assigns(:provider).telephone
    assert_tag "h1", :content => Provider.find(1).name
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag :tag => 'table', :children => { :count => Provider.count + 1, :only => {:tag => 'tr'} }
    Provider.find_each do |a|
      assert_tag :tag => 'td', :content => a.name
    end
  end

end