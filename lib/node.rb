class Node

  # attr_reader :object
  attr_accessor :next, :object

  def initialize(object)
    @object = object
    @next = nil
  end

end
