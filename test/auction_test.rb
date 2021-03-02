require 'minitest/autorun'
require 'minitest/pride'
require './lib/auction'
require './lib/attendee'
require './lib/item'

class Test < Minitest::Test
  def setup
    @auction = Auction.new
    @attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    @attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    @attendee3 = Attendee.new(name: 'Mike', budget: '$100')
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Auction, @auction
    assert_equal [], @auction.items
  end

  def test_it_can_add_items
    @auction.add_item(@item1)
    @auction.add_item(@item2)

    assert_equal [@item1, @item2], @auction.items
  end

  def test_it_can_name_items
    @auction.add_item(@item1)
    @auction.add_item(@item2)

    assert_equal ["Chalkware Piggy Bank", "Bamboo Picture Frame"], @auction.item_names
  end

  def test_it_can_add_bids
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)

    assert_equal ({}), @item1.bids

    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)

    assert_equal ({
                    @attendee2 => 20,
                    @attendee1 => 22
                  }), @item1.bids
  end

  def test_current_high_bid
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)

    assert_equal 22, @item1.current_high_bid
  end

  def test_it_can_return_unpopular_items
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)

    assert_equal [@item2, @item3, @item5], @auction.unpopular_items

    @item3.add_bid(@attendee2, 15)

    assert_equal [@item2, @item5], @auction.unpopular_items
  end

  def test_it_can_add_potential_revenue
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)
    
    assert_equal 87, @auction.potential_revenue
  end

  def test_it_can_list_auction_bidders
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)
    
    assert_equal ["Megan", "Bob", "Mike"], @auction.bidders
  end

  def test_it_can_return_bidder_info
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)

    assert_equal ({
                  @attendee1 =>
                    {
                      :budget => 50,
                      :items => [@item1]
                    },
                  @attendee2 =>
                    {
                      :budget => 75,
                      :items => [@item1, @item3]
                    },
                  @attendee3 =>
                    {
                      :budget => 100,
                      :items => [@item4]
                    }
                }), @auction.bidder_info

  end

  def test_it_can_close_bids
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)
    
    assert_equal ({
                    @attendee2 => 20,
                    @attendee1 => 22
                  }), @item1.bids
    
    @item1.close_bidding
    @item1.add_bid(@attendee3, 70)

    assert_equal ({
                    @attendee2 => 20,
                    @attendee1 => 22
                  }), @item1.bids
  end
end