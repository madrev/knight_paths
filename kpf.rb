require_relative "tree_node"

class KnightPathFinder
  KNIGHT_MOVES = [[-2, 1], [-2, -1], [2, 1], [2, -1], [1, -2], [1, 2], [-1, -2], [-1, 2]]

  attr_reader :grid, :position

  def initialize(pos)
    @position = pos
    @grid = Array.new(8) { Array.new(8) }
    @visited_positions = [pos]
  end

  def new_move_positions(pos)
    candidates = self.valid_moves(pos)
    candidates.reject! {|candidate| @visited_positions.include?(candidate)}
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

end
