class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key, @val = key, val
    @next, @prev= nil, nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @next.prev = @prev
    @prev.next = @next
  end
end



class LinkedList
  #include: O(n)
  #insert: O(n)
  #remove: O(n)
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    self.each_with_index do |node, idx|
      return node if idx == i
    end
  end

  def empty?
    @head.next == @tail
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def get(key)
    return nil if empty?

    current_node = @head
    until current_node == @tail
      current_node = current_node.next
      return current_node.val if current_node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = @tail
    new_node.prev = @tail.prev
    new_node.prev.next = new_node
    @tail.prev = new_node

    new_node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return node
      end
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.remove
        return node
      end
    end
  end

  def each
    current_node = first
    while current_node
      break if current_node == @tail
      if block_given?
        yield (current_node)
        current_node = current_node.next
      end
    end
  end

end
