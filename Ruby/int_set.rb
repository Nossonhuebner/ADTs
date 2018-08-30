class MaxIntSet
  #contains a predetermined range of positive integers. Initialized with the max value.
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    includes = @store[num]
    includes
  end

  private

  def is_valid?(num)
    return false  if num > @store.length || num < 0
    true
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  #contains an arbitrary range of numbers, with a fixed number of buckets to store them in
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num) #checks corresponding bucket
  end

  private

  def [](num)
    @store[num % num_buckets] #returns corresponding bucket
  end

  def num_buckets
    @store.length
  end
end
