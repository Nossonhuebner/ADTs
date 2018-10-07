require 'byebug'
class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i > @count || i < 0
    @store[i]
  end

  def []=(i, val)
    until i < @store.length
      resize!
    end
    @store[i] = val
    @count = i
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each { |el| return true if el == val}
    false
  end

  def push(val)
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    store = @store
    @store = StaticArray.new(capacity + 1)
    @store[0] = val
    i = 0
    while i < store.length
      self.push(store[i])
      i += 1
    end
  end

  def pop
    return nil if @count = 0

    popped = last
    last = nil
    @count -= 1
    popped
  end

  def shift
    store = @store
    @store = StaticArray.new(capacity)
    i = 1
    while i < store.length
      self.push(store[i])
      i += 1
    end
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each
    i = 0
    while i < @count
      yield @store[i]
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    store = @store
    @store = StaticArray.new(capacity * 2)
    i = 0
    while i < store.length
      self.push(store[i])
      i += 1
    end
  end
end
