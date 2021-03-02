class Attendee
  attr_reader :name, :budget
  
  def initialize(person)
    @name = person[:name]
    @budget = person[:budget]
  end
end