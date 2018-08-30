class MaxIntSet
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
