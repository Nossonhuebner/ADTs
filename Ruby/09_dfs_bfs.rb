class Node
  attr_reader :children, :val

  def initialize(val = nil)
    @val = val
    @children = []
  end

  def bfs(val)
    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.val == val
      node.children.each { |child| queue.push(child)}
    end
  end

  def dfs(val)
    return self if self.val == val
    self.children.each do |child|
      search_result = child.dfs(val)
      return search_result if search_result
    end
    nil
  end

  def add_val(val)
    if @children.empty?
      self.add_child(val)
    else
      @children[-1].add_val(val)
    end
  end

  def add_child(val)
    @children.push(self.class.new(val))
  end


end


class Tree
  attr_reader :root

  def initialize(val = nil)
    @root = Node.new(val)
  end

  def bfs(val)
    root.bfs(val)
  end

  def dfs(val)
    root.dfs(val)
  end

  def add_val(val)
    root.add_val(val)
  end

end
