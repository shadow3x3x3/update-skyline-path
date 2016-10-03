class GrowingGraph
  attr_reader :outer_nodes, :inner_nodes

  def initialize(neighbors_hash, start_nodes)
    @neighbors_hash = neighbors_hash

    @outer_nodes = [start_nodes]
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
      @inner_nodes << o_n
      return new_partial_outer_nodes
    end
    o_n
  end
end