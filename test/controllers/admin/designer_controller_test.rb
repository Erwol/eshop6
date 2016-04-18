require 'test_helper'

class Admin::DesignerControllerTest < ActionController::TestCase
  fixtures :designers

  test "new" do
    get :new  
    assert_template 'admin/designer/new'  
    assert_tag 'h1', :content => 'Añadir un nuevo diseñador'  
    assert_tag 'form', :attributes => { :action => '/admin/designer/create' }   
  end

  test "create" do
    get :new    
    assert_template 'admin/designer/new'
    assert_difference(Designer, :count) do
      post :create, :designer => {:name => 'Rodrigo', :telephone => 956245152, :enterprise => 'Pryca'}
      assert_response :redirect, "Errores en el modelo: #{assigns(:designer).errors.full_messages.to_sentence}"
      assert_redirected_to :action => 'index'      
    end
    assert_equal 'El diseñador Rodrigo fue añadido correctamente.', flash[:notice]
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag :tag => 'input', :attributes => { :name => 'designer[name]', :value => 'Juan' }
    assert_tag :tag => 'input', :attributes => { :name => 'designer[telephone]', :value => 956214584 }
    assert_tag :tag => 'input', :attributes => { :name => 'designer[enterprise]', :value => 'Macro' }
  end

  test "update" do
    post :update, :id => 1, :designer => { :name => 'Juan', :telephone => 956214584, :enterprise => 'Macro' }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Juan', Designer.find(1).name
  end

  test "test_destroy" do
    assert_difference(Designer, :count, -1) do
      post :destroy, :id => 1
      assert_equal flash[:notice], 'El diseñador Juan fue eliminado correctamente.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_tag :tag => 'div', :attributes => {:id => 'notice'},
        :content => 'El diseñador Juan fue eliminado correctamente.'
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/designer/show'
    assert_equal 'Juan', assigns(:designer).name
    assert_equal 956214584, assigns(:designer).telephone
    assert_equal 'Macro', assigns(:designer).enterprise
    assert_tag "h1", :content => Designer.find(1).name
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag :tag => 'table', :children => { :count => Designer.count + 1, :only => {:tag => 'tr'} }
    Designer.find_each do |a|
      assert_tag :tag => 'td', :content => a.name
    end
  end

end
