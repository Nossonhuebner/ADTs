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

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_index = 0
  end

  def [](i)
    return nil if i >= capacity
    @store[i]
  end

  def []=(i, val)
    if i < capacity
      @store[i] = val
    else
      while capacity < i
        resize!
      end
      @store[i] = val
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each {|el| return true if el == val}
    false
  end

  def push(val)
    @store[@count] = val
    @count += 1
    resize! if @count == capacity
  end

  def unshift(val)
    if @start_index > 0
      @start_index -= 1
      @store[@start_index] = val
    else

    end
  end

  def pop
    return nil if @count = 0
    @start_index += 1
  end

  def shift
    return nil if @count = 0
  end

  def first
    @store[0]
  end

  def last
    @store[capacity-1]
  end

  def each
    i = @start_index
    while i < @store.length
      yield (@store[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    i = 0
    while i < capacity
      return false unless self[i] == other[i]
      i += 1
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    old_store = @store
    @store = StaticArray.new(capacity * 2)
    i = @start_index
    while i < @count
      @store[i] = old_store[i]
      i += 1
    end
  end
end
