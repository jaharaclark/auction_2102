require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class Test < Minitest::Test
  def setup
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Item, @item1
    assert_equal 'Chalkware Piggy Bank', @item1.name
    assert_equal ({}), @item1.bids
  end
end