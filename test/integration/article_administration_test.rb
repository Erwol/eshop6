require File.dirname(__FILE__) + '/../test_helper'

class ArticleAdministrationTest < ActionDispatch::IntegrationTest

  test "article_aministration" do
    provider = Provider.create(:name => 'Articles', :telephone => 956824514)
    designer = Designer.create(:name => 'Articles of Ruby', :telephone => 956824514, :enterprise => 'Ruby')
    george = new_session_as(:george)

    new_article_ruby = george.add_article :article => {
      :name => 'A new Article of Ruby',
      :provider_id => provider.id,
      :designer_ids => [designer.id],
      :provided_at => Time.now,
      :description => 'A new Article of Ruby',
      :price => 45.5
    }

    george.list_articles
    george.show_article new_article_ruby

    george.edit_article new_article_ruby, :article => {
      :name => 'A very new Article of Ruby',
      :provider_id => provider.id,
      :designer_ids => [designer.id],
      :provided_at => Time.now,
      :description => 'A very new Article of Ruby',
      :price => 50
    }

    bob = new_session_as(:bob)
    bob.delete_article new_article_ruby
  end

  private

  module ArticleTestDSL
    attr_writer :name

    def add_article(parameters)
      designer = Designer.first
      provider = Provider.first
      get '/admin/article/new'
      assert_response :success
      assert_template 'admin/article/new'
      assert_tag :tag => 'option', :attributes => { :value => provider.id }
      assert_tag :tag => 'select', :attributes => { :name => 'article[designer_ids][]' }
      post '/admin/article/create', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/article/index'
      page = Article.all.count / 5 + 1
      get "/admin/article/index/?page=#{page}"
      assert_tag :tag => 'td', :content => parameters[:article][:name]
      article = Article.find_by_name(parameters[:article][:name])
      return article;
    end

    def edit_article(article, parameters)
      get "admin/article/edit?id=#{article.id}"
      assert_response :success
      assert_template 'admin/article/edit'
      post "/admin/article/update?id=#{article.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/article/show'
    end

    def delete_article(article)
      post "/admin/article/destroy?id=#{article.id}"
      assert_response :redirect
      follow_redirect!
      assert_template 'admin/article/index'
    end

    def show_article(article)
      get "/admin/article/show/#{article.id}"
      assert_response :success
      assert_template 'admin/article/show'
    end

    def list_articles
      get 'admin/article/index'
      assert_response :success
      assert_template 'admin/article/index'
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(ArticleTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
