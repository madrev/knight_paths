class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) if parent
    @parent = node
    node.children << self if node
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "not a child" if !children.include?(child_node)
    child_node.parent = nil
    children.delete(child_node)
  end

  def dfs(target_value)
    return self if value == target_value

    children.each do |child|
      current_node = child.dfs(target_value)
      return current_node if current_node
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each { |child| queue << child }
    end

    nil
  end
end
