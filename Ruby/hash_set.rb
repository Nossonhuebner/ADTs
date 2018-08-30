class HashSet

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return nil if include?(key)
    self[key] << key
    @count += 1
    resize! if @count == num_buckets

    key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](key)
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store
    @store = Array.new(count * 2) { Array.new }
    @count = 0

    prev_store.flatten.each do |el|
      insert(el)
    end
  end
end
