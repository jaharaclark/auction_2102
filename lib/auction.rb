require './lib/item'
class Auction
    attr_reader :items
    
    def initialize
      @items = []
    end

    def add_item(item)
      @items << item
    end

    def item_names
      @items.map do |item|
        item.name
      end
    end

    def unpopular_items
      @items.find_all do |item|
        item.bids == {}
      end
    end

    def potential_revenue
      @items.sum do |item|
       item.current_high_bid.to_i
      end
    end

    def bidders
      names = []
      @items.map do |item|
        item.bids.find_all do |attendee, budget|
            names << attendee.name
        end
      end
      names.shift
      names
    end

    def bidder_info
      hash = Hash.new{ |hash, key| hash[key] = []}
      @items.each do |item|
        item.bids.each do | key, value|
          hash[key] << {:budget => key.budget.delete("$").to_i,
                        :items => item
          }
        end
      end
      hash
    end
end