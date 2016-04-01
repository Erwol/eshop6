require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  test "create" do
    provider = Provider.new(:name => 'Sudaderas Volcom', :telephone => 956223465)
    assert_equal 'Sudaderas Volcom', provider.name
    assert_equal 956223465, provider.telephone
    assert provider.save
  end
  test "failing_create" do
    provider = Provider.new(:name => 'Sudaderas Volcom', :telephone => 956223465)
    assert_equal false, provider.save
    assert_equal 1, provider.errors.count
    assert provider.errors[:name]
    assert provider.errors[:telephone]
  end
end
