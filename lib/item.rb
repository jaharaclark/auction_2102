class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, amount)
    if close_bidding
      @bids[attendee] = amount
    end
  end

  def current_high_bid
    bid_amounts = []
    @bids.each do |bid|
      bid_amounts << bid[1]
    end
    bid_amounts.max
  end

  def close_bidding
    @bids.length < 2
  end
end