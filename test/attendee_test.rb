require 'minitest/autorun'
require 'minitest/pride'
require './lib/attendee'

class Test < Minitest::Test
  def setup
    @attendee = Attendee.new(name: 'Megan', budget: '$50')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Attendee, @attendee
    assert_equal 'Megan', @attendee.name
    assert_equal '$50', @attendee.budget
  end
end