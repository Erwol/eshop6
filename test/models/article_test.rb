require File.dirname(__FILE__) + '/../test_helper'

class ArticleTest2 < ActiveSupport::TestCase
  fixtures :designers, :providers, :articles, :articles_designers

  test "failing_create" do
    article = Article.new
    assert_equal false, article.save
    assert_equal 5, article.errors.count
    assert article.errors[:name]
    assert article.errors[:provider]
    assert article.errors[:designers]
    assert article.errors[:provided_at]
    assert article.errors[:description]
    assert article.errors[:price]
  end

  test "create" do
    article = Article.new(
      :name => 'Ruby on Rails',
      :designers => Designer.all,
      :provider_id => Provider.find(1).id,
      :provided_at => Time.now,
      :description => 'A great article',
      :price => 45.5
    )
  assert article.save
  end

  test "has_many_and_belongs_to_mapping" do
    apress = Provider.find_by_name("Juan");
    count = apress.articles.count
    article = Article.new(
      :name => 'Pro Rails E-Commerce 8th Edition',
      :designers => [Designer.find_by_name('Juan'),
                   Designer.find_by_name('Pepe')],
      :provider_id => apress.id,
      :provided_at => Time.now,
      :description => 'E-Commerce on Rails',
      :price => 55.5
    )
    apress.articles << article
    apress.reload
    article.reload
    assert_equal count + 1, apress.articles.count
    assert_equal 'Juan', article.provider.name
  end

  test "has_many_and_belongs_to_many_designers_mapping" do
    article = Article.new(
      :name => 'Pro Rails E-Commerce 8th Edition',
      :designers => [Designer.find_by_name('Juan'),
                   Designer.find_by_name('Pepe')],
      :provider_id => Provider.find_by_name('Juan').id,
      :provided_at => Time.now,
      :description => 'E-Commerce on Rails',
      :price => 55.5
    )
    assert article.save
    article.reload
    assert_equal 2, article.designers.count
    assert_equal 2, Designer.find_by_name('Juan').articles.count
  end
end
