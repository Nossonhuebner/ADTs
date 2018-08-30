class MaxIntSet
  #contains a predetermined range of positive integers. Initialized with the max value.
  #include: O(1)
  #insert: O(1)
  #remove: O(1)
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
  #contains an arbitrary range of integers, with a fixed number of buckets to store them in.
  #lookup time is O(n), because num_buckets is fixed while n grows, increasing the average amount of
  #bucket collisions and therefore lookup time.
  #(e.g. where num_buckets == 20, lookup time is O(n/20) == O(n))
  #include: O(n)
  #insert: O(n) (O(1) when not checking for inclusion)
  #remove: O(n)
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



class ResizingIntSet
  #contains an arbitrary range of integers, with a fixed number of buckets to store them in.
  #operations will be done in O(1) since num_buckets will always be <= n, (O(n/n)).
  #a resize will be O(n) but amortized time will remain constant.
  #include: O(1)
  #insert: O(1)
  #remove: O(1)
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      self[num] << num
      @count += 1
      resize! if num_buckets == @count #resizes when numbuckets == n for even distribution

      num
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
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

  def resize!
    prev_store = @store
    @store = Array.new(@count * 2, Array.new)
    @count = 0

    prev_store.flatten.each do |el|
      insert(el)
    end
  end
end
