require_relative "00_tree_node"

class KnightPathFinder
  KNIGHT_MOVES = [[-2, 1], [-2, -1], [2, 1], [2, -1], [1, -2], [1, 2], [-1, -2], [-1, 2]]

  attr_reader :grid, :position

  def initialize(pos)
    @position = pos
    @visited_positions = [pos]
    build_move_tree
  end

  def new_move_positions(pos)
    candidates = self.class.valid_moves(pos)
    candidates.reject! { |candidate| @visited_positions.include?(candidate)}
    @visited_positions += candidates
    candidates
  end

  def self.valid_moves(pos)
    row, col = pos
    result = []
    KNIGHT_MOVES.each do |move|
      move_row = row + move.first
      move_col = col + move.last
      new_pos = [move_row, move_col]
      result << new_pos if self.move_in_bounds?(new_pos)
    end
    result
  end

  def self.move_in_bounds?(pos)
    pos.none? { |num| num < 0 || num >= 8 }
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(position)

    queue = [@root_node]

    until queue.empty?
      current_node = queue.shift
      next_positions = new_move_positions(current_node.value)
      next_positions.each do |pos|
        next_node = PolyTreeNode.new(pos)
        current_node.add_child(next_node)
        queue << next_node
      end
    end
  end

  def trace_path_back(end_node)
    path = []
    current_node = end_node
    until path.last == @position
      path << current_node.value
      current_node = current_node.parent
    end
    path
  end

  def find_path(end_pos)
    end_node = @root_node.dfs(end_pos)
    trace_path_back(end_node).reverse
  end



end
