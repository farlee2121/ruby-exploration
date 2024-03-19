class Node
  def initialize()
  end

  def next 
    @next
  end
  def next=(value) 
    @next = value
  end
end

def loop_size(node)
    seen = []
    current = node
    while seen.include?(current) == false do
        seen.append(current)
        current = current.next
    end
    
    first_repeated = current
    loop_size = seen.length - seen.find_index(first_repeated)
    return loop_size
end


#use this if you want to create your code on you computer the class of the node is in the description
def create_chain_for_test(tail_size, loop_size)
    prev_node = start = Node.new
    start.next = start
    return start if loop_size == 1
    (1..tail_size).each do |i|
      prev_node.next = Node.new
      prev_node = prev_node.next
    end
    end_loop = prev_node
    (1...loop_size).each do |i|
      prev_node.next = Node.new
      prev_node = prev_node.next
    end
    prev_node.next = end_loop
    start
  end


RSpec.describe 'Loop Size' do
    it "Sample Tests" do
      expect(loop_size(create_chain_for_test(3,12))).to  eq(12)
      expect(loop_size(create_chain_for_test(0,12))).to  eq(12)
      expect(loop_size(create_chain_for_test(1,0))).to  eq(1)
      expect(loop_size(create_chain_for_test(2,0))).to  eq(1)
    end
end