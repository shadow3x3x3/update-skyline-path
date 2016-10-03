require 'pry'

class GrowingGraph
  attr_reader :outer_nodes, :inner_nodes

  def initialize(neighbors_hash, start_nodes)
    @neighbors_hash = neighbors_hash

    @outer_nodes = start_nodes
    @inner_nodes = []
  end

  # inner_nodes will be add
  # outer_nodes will be replace
  def growing
    new_outer_nodes = []
    @outer_nodes.each do |o_n|
      new_partial_outer_nodes = set_outer_nodes(@neighbors_hash[o_n])
      new_outer_nodes << check_partial_outer_nodes(new_partial_outer_nodes, o_n)
    end
    @outer_nodes = new_outer_nodes.compact.flatten
  end

  private

  def set_outer_nodes(temp_outer_nodes)
    new_partial_outer_nodes = []
    temp_outer_nodes.each do |temp_o_n|
      next if @inner_nodes.include?(temp_o_n)      
      new_partial_outer_nodes << temp_o_n
    end
    new_partial_outer_nodes
  end

  def check_partial_outer_nodes(new_partial_outer_nodes, o_n)
    unless new_partial_outer_nodes.empty?
      @inner_nodes << o_n unless @inner_nodes.include?(o_n)
      return new_partial_outer_nodes
    end
    o_n
  end
end

NeighborsHash = {
  1  => [2, 3, 4, 5, 14],
  2  => [1, 6, 7, 13],
  3  => [1, 11, 12, 13],
  4  => [1, 5, 8],
  5  => [1, 4, 9, 10],
  6  => [2],
  7  => [2],
  8  => [4],
  9  => [5],
  10 => [5],
  11 => [3],
  12 => [3],
  13 => [2, 3],
  14 => [1]                  
}

gg = GrowingGraph.new(NeighborsHash, [1, 2])
puts gg.outer_nodes
puts "--"
puts gg.inner_nodes
puts "--"
puts '1-G'
gg.growing
puts gg.outer_nodes
puts "--"
puts gg.inner_nodes
puts "--"
puts '2-G'
gg.growing
puts gg.outer_nodes
puts "--"
puts gg.inner_nodes
puts "--"

