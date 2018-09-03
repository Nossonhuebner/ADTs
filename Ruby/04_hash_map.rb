require_relative '03_linked_list'

class HashMap
  #operations will be done in O(1) since num_buckets will scale with n, (O(n/n)).
  #a resize will be O(n) but amortized time will remain constant.
  #include: O(1)
  #insert: O(1)
  #remove: O(1)
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      @count += 1
      bucket(key).append(key, val)
      resize! if count == num_buckets
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1
    bucket(key).remove(key)
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@count * 2) { LinkedList.new }
    @count = 0
    old_store.each do |bucket|
      bucket.each do |node|
        self.set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets] # returns the corresponding LinkedList for key's value
  end
end
