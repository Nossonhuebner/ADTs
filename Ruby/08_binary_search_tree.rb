require 'byebug'
class Node
  attr_accessor :val, :left, :right

  def initialize(val = nil)
    @val = val
    @right = nil
    @left = nil
  end

  def add_child(value)
    #root node
    if !self.val
      self.val = value
    elsif value < self.val
      left ? left.add_child(value) : self.left = Node.new(value)
    else
      right ? right.add_child(value) : self.right = Node.new(value)
    end
  end

  def traverse
    left.traverse if left
    puts self.val
    right.traverse if right
  end

  def search(value)
    if self.val == value
      return self.val
    elsif value < self.val && left
      found = left.search(value)
      return "#{self.val} -> #{found}" if found
    elsif right
      found = right.search(value)
      return "#{self.val} -> #{found}" if found
    end
  end
end

class Tree
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def add_val(val)
    @root.add_child(val)
  end

  def traverse
    root.traverse
  end

  def search(val)
    root.search(val)
  end

end
