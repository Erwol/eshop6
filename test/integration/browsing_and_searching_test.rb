require File.dirname(__FILE__) + '/../test_helper'

class BrowsingAndSearchingTest < ActionDispatch::IntegrationTest
  fixtures :providers, :designers, :articles, :articles_designers

  test "browse" do
    jill = new_session_as :jill
    jill.index
    jill.second_page
    jill.article_details 'Pride and Prejudice'
    jill.latest_articles
  end

  module BrowsingTestDSL
    include ERB::Util
    attr_writer :name

    def index
      get 'catalog/index'
      assert_response :success
      assert_tag :tag => 'dl', :attributes => { :id => 'articles' },
                 :children => { :count => 5, :only => { :tag => 'dt' }}
      assert_tag :tag => 'dt', :content => 'The Idiot'
      check_article_links
    end

    def second_page
      get 'catalog/index?page=2'
      assert_response :success
      assert_template 'catalog/index'
      assert_equal Article.find_by_name('Pro Rails E-Commerce'),
                   assigns(:articles).last
      check_article_links
    end
  end

  def article_details(name)
    @article = Article.where(:name => name).first
    get "catalog/show/#{@article.id}"
    assert_response :success
    assert_template 'catalog/show'
    assert_tag :tag => 'h1', :content => @article.name
    assert_tag :tag => 'h2', :content => "por #{@article.designers.map{|a| a.name}.join(", ")}"
  end

  def check_article_links
    for article in assigns :articles
      assert_tag :tag => 'a', :attributes => { :href => "/catalog/show/#{article.id}" }
    end
  end

  def latest_articles
    get 'catalog/latest'
    assert_response :success
    assert_template 'catalog/latest'
    assert_tag :tag => 'dl', :attributes => { :id => 'articles' },
               :children => { :count => 5, :only => { :tag => 'dt' } }
    @articles = Article.latest(5)
    @articles.each do |a|
      assert_tag :tag => 'dt', :content => a.name
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
