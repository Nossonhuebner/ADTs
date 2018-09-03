require_relative '04_hash_map'
require_relative '03_linked_list'

class LRUCache
  #'getting' any key or 'ejecting' oldest key = O(1) time
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new(max + 1) # +1 to compensate for added node before oldest one is ejected
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = @map[key]

    if node
      update_node!(node) #update position in list
      node
    else
      @map[key] = @store.append(key, @prc.call(key))
       #computes value to be cached for key and inserts it into List and map
      eject! if count > @max
      node
    end
  end


  def to_s #for testing purposes
    @store.each {|node| puts node.key}
    puts '_______________'
  end

  private

  def update_node!(node)
    #moves an existing node to the end of the list
    node.remove
    @map[node.key] = @store.append(node.key, node.val)
  end

  def eject!
    key = @store.first.key
    @store.first.remove #remove from LinkedList
    @map.delete(key)  #remove from HashMap
    nil
  end
end
