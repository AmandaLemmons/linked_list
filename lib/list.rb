class List
  attr_accessor :head, :tail, :count
  include Enumerable
  require 'pry'

  def initialize(options={})
    @head = nil
    @tail = nil
    @count = 0
    @sort_order = options[:sorted]
    @lists = []
  end

  # add to end of the list
  def add(object)
    node = Node.new(object)
    node.object = object

    if @count == 0
      @head = node
      @tail = node
      node.next = nil
    else
      @tail.next = node
      @tail = @tail.next
      @tail.next = nil
    end
    @count += 1
    @lists << node

    # add in the correct sort order (haven't been able to put the method together/ check them. )
      # checks to see if the list is a sorted list or not / if there is a list
      # if (@sort_order != 0 )&& (@count > 0)
      #   first = @head
      #   second = @head.next
      #   new_node = node
      # only one item in list and new item goes last
      # elsif (first.object < new_node.object) && (second == nil)
      #    first.next = new_node
      #    @tail = new_node
      #    @tail.next = nil
      #    end
      # only one item in list and new item goes first
      # elsif (first.object < new_node.object)
      #   @head = new_node
      #   @head.next = first
      # this works if the new_node goes between two exisiting nodes (ex[9, 11] --> wanting to add 10)
    # while second != nil
    #   until first.object > new_node.object
    #     previous = first
    #     first = second
    #     second = first.next
    #   end
    #   previous.next = new_node
    #   new_node.next = first
    # end
  end

  # enumerable mixin method
  def each(&block)
    return enum_for(:each) unless block_given?
    @lists.each &block
  end

  # returns all elements in list
  def elements
    if @sort_order == 0 || @sort_order == nil
      to_a
    else
      to_a.sort
    end
  end

  # returns true if the list is empty, false otherwise
  def empty?
    if to_a.empty?
      true
    else
      false
    end
  end

  # returns length of list
  def length
    @count
  end

  # returns true if object is a member of the list, false otherwise
  def member?(object)
    if to_a.include?(object)
      true
    else
      false
    end
  end

  # returns and removes the first element of the list; or nil if the list is empty
  def pop
    return nil if @count < 1
      # remove the element from the array
      @lists.shift

      # remove the first element and set second element to first position
      pop = @head.object
      @head = @head.next
      @count -= 1
      pop

  end
  # creates an array of the objects in the list
  def to_a
    return nil if @count < 1
    each.collect {|node| node.object }
  end
end
