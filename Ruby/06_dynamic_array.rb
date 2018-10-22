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
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i = validator(i)
    return nil if !i || i > @count
    @store[i]
  end

  def []=(i, val)
    i = validator(i)
    return nil unless i

    while i >= @store.length
      resize!
    end
    debugger
    @store[i] = val
    @count = i + 1 if i >= @count
  end

  def validator(i)
    if i >= 0
      i
    elsif i < -@count
      return nil
    else
      i + @count
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each { |el| return true if el == val}
    false
  end

  def push(val)
    resize! if @count == @store.length
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    old_store = @store
    @store = StaticArray.new(capacity + 1)
    @count = 0
    self.push(val)
    i = 0
    while i < old_store.length
      self.push(old_store[i])
      i += 1
    end
  end

  def pop
    return nil if @count == 0
    popped = last
    @count -= 1
    @store[@count] = nil
    popped
  end

  def shift
    return nil if @count == 0

    old_store, old_count = @store,  @count
    @store = StaticArray.new(capacity)
    @count = 0

    i = 1
    while i < old_count
      self.push(old_store[i])
      i += 1
    end
    old_store[0]
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
    return false if count != other.count
    self.each_with_index do |el, i|
      return false unless self[i] == other[i]
    end
    @store
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    old_store, old_count = @store, @count
    @store = StaticArray.new(capacity * 2)
    @count = 0

    i = 0
    while i < old_count
      self.push(old_store[i])
      i += 1
    end
  end
end

# if $PROGRAM_NAME == __FILE__
#   a = DynamicArray.new(2)
#   i = 0
#   while i < 20
#     a.push(i)
#     i += 1
#   end
# end
