require 'minitest/autorun'
require './lib/list'
require './lib/node'
require 'pry'

describe List do

  let(:list) { List.new }

  describe "#new_list" do
    let(:list) {List.new}
    it "should build an empty list" do
      list.head.must_equal nil
      list.tail.must_equal nil
      list.elements.must_equal nil
      list.count.must_equal 0
    end
  end

  describe "#add" do
    describe "with regular list" do
      let(:list) { List.new(sorted: 0) }
      it "should add elements to end of list" do
        list.length.must_equal 0
        list.add('foo')
        list.length.must_equal 1
        list.elements.must_equal(['foo'])
        list.head.object.must_equal('foo')
        list.tail.object.must_equal('foo')


        list.add('bar')
        list.length.must_equal 2
        list.elements.must_equal(['foo', 'bar'])
        list.head.object.must_equal('foo')
        list.tail.object.must_equal('bar')
        #
        list.add('baz')
        list.length.must_equal 3
        list.elements.must_equal(['foo', 'bar', 'baz'])
        list.head.object.must_equal('foo')
        list.tail.object.must_equal('baz')

        list.add('ant')
        list.length.must_equal 4
        list.elements.must_equal(['foo', 'bar', 'baz', 'ant'])
        list.head.object.must_equal('foo')
        list.tail.object.must_equal('ant')
      end
    end

    describe "with sorted list" do
      let(:list) { List.new(sorted: 1) }

      it "should add elements based on sort order" do
        list.length.must_equal 0

        list.add('foo')
        list.length.must_equal 1
        list.elements.must_equal(['foo'])
        list.head.object.must_equal('foo')
        list.tail.object.must_equal('foo')

        list.add('bar')
        list.length.must_equal 2
        list.elements.must_equal(['bar', 'foo'])
        list.head.object.must_equal('bar')
        list.tail.object.must_equal('foo')

        list.add('baz')
        list.length.must_equal 3
        list.elements.must_equal(['bar', 'baz', 'foo'])
        list.head.object.must_equal('bar')
        list.tail.object.must_equal('foo')

        list.add('ant')
        list.length.must_equal 4
        list.elements.must_equal(['ant', 'bar', 'baz','foo'])
        list.head.object.must_equal('ant')
        list.tail.object.must_equal('foo')
      end
    end
   end

  describe "#member?" do
    let(:data) { [1,2] }
    before do
      data.each do |i|
        list.add(i)
      end
    end

    describe "when object is member of list" do
      it "should return true" do
        list.member?(data[0]).must_equal true
        list.add(3)
        list.member?(3).must_equal true
      end
    end

    describe "when object is not member of list" do
      it "should return false" do
        list.member?('xxx').must_equal false
      end
    end
   end

  describe "#pop" do
    describe "with empty list" do
      it "should return nil" do
        list.length.must_equal 0
        list.pop.must_equal nil
      end
    end

    describe "with non-empty list" do
      let(:data) { [1,2] }

      before do
        data.each do |i|
          list.add(i)
        end
      end

      it "should get and remove first element from list" do
        list.elements.must_equal(data)
        list.pop.must_equal(data[0])
        list.elements.must_equal(data.slice(1, data.length))
      end

      it "should add unsorted elements to end of list and remove first element from list" do
        list.elements.must_equal(data)
        list.pop.must_equal(data[0])

        list.add(3)
        list.length.must_equal 2
        list.elements.must_equal([2, 3])

        list.add(1)
        list.length.must_equal 3
        list.elements.must_equal([2, 3, 1])
      end
    end
  end

  describe "with non-empty sorted list" do
    let(:data) { [1,2] }
    let(:list) { List.new(sorted: 1) }

    before do
      data.each do |i|
        list.add(i)
      end
    end

    it "should add element in sorted position and remove first element" do
      list.elements.must_equal(data)
      list.pop.must_equal(data[0])

      list.add(0)
      list.length.must_equal 2
      list.elements.must_equal([0, 2])

      list.add(1)
      list.length.must_equal 3
      list.elements.must_equal([0, 1, 2])
    end
  end

end
