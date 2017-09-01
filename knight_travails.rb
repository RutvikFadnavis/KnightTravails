class Node
	attr_accessor :value, :parent, :child_1, :child_2, :child_3, :child_4, :child_5, :child_6, :child_7, :child_8, :traversed

	def initialize(value, parent =nil, child_1 =nil, child_2 =nil, child_3 =nil, child_4= nil, child_5= nil, child_6 =nil, child_7= nil, child_8= nil)
		@value = value
		@parent = parent
		@child_1 = child_1
		@child_2 = child_2			
		@child_3 = child_3
		@child_4 = child_4
		@child_5 = child_5
		@child_6 = child_6
		@child_7 = child_7	
		@child_8 = child_8
		@traversed = [self.value]
	end
end

class Knight
	attr_accessor :root, :destination

	@full = []
	for i in 0..7
		for j in 0..7
			@full << [i,j]
		end
	end

	def initialize
		@root = nil
		@destination = nil
	end

	def traversed?(node, offset)
		node.traversed.each do |position|
			return true if position == [node.value[0] + offset[0], node.value[1] + offset[1]]
		end
		return false
	end

	def out_of_board?(node, offset)
		return true if (node.value[0] + offset[0] > 7)or(node.value[0] + offset[0] < 0)or(node.value[1] + offset[1] > 7)or(node.value[1] + offset[1] < 0) 
		return false
	end

	def some_child?(node)
		answer = false
		answer = answer || (node.child_1.value == @destination) unless node.child_1 == nil
		answer = answer || (node.child_2.value == @destination) unless node.child_2 == nil
		answer = answer || (node.child_3.value == @destination) unless node.child_3 == nil
		answer = answer || (node.child_4.value == @destination) unless node.child_4 == nil
		answer = answer || (node.child_5.value == @destination) unless node.child_5 == nil
		answer = answer || (node.child_6.value == @destination) unless node.child_6 == nil
		answer = answer || (node.child_7.value == @destination) unless node.child_7 == nil
		answer = answer || (node.child_8.value == @destination) unless node.child_8 == nil
	return answer
	end

	def build_tree(node =@root)
		return if node.traversed.length >7
		return if some_child?(node)
		return if node.traversed.include? @destination
		return if node.traversed == @full
		for i in -2..2
			for j in -2..2
				unless out_of_board?(node, [i,j]) or traversed?(node, [i,j]) or (i.abs == j.abs) or (i*j == 0)
					case([i,j])
						when [-1,-2]
							if node.child_1 == nil
								node.child_1 = Node.new([node.value[0]+i,node.value[1]+j], node)
							else
								build_tree(node.child_1)
							end
							node.child_1.traversed += node.traversed
						when [-2,-1]
							if node.child_2 == nil
								node.child_2 = Node.new([node.value[0]+i,node.value[1]+j], node)
							else
								build_tree(node.child_2)
							end
							node.child_2.traversed  += node.traversed
						when [-2,1]
							if node.child_3 == nil
								node.child_3 = Node.new([node.value[0]+i,node.value[1]+j], node)
							else
								build_tree(node.child_3)
							end
							node.child_3.traversed += node.traversed
						when [-1,2]
							if node.child_4 == nil
								node.child_4 = Node.new([node.value[0]+i,node.value[1]+j], node)
							else
								build_tree(node.child_4)
							end
							node.child_4.traversed += node.traversed
						when [1,2]
							if node.child_5 == nil
								a = node.value[0]+i
								b = node.value[1]+j
								node.child_5 = Node.new([node.value[0]+i,node.value[1]+j], node)
							else
								build_tree(node.child_5)
							end
							node.child_5.traversed += node.traversed
						when [2,1]
							if node.child_6 == nil
								node.child_6 = Node.new([node.value[0]+i,node.value[1]+j], node)
							else
								build_tree(node.child_6)
							end
							node.child_6.traversed += node.traversed
						when [2,-1]
							if node.child_7 == nil
								node.child_7 = Node.new([node.value[0]+i,node.value[1]+j], node)
							else
								build_tree(node.child_7) 
							end
							node.child_7.traversed += node.traversed
						when [1,-2]
							if node.child_8 == nil
								node.child_8 = Node.new([node.value[0]+i,node.value[1]+j], node)
							else
								build_tree(node.child_8)
							end
							node.child_8.traversed += node.traversed
					end
				end
			end
		end		
		return if node.value == @destination

		build_tree(node.child_1) if (node.child_1 != nil)
		build_tree(node.child_2) if (node.child_2 != nil)
		build_tree(node.child_3) if (node.child_3 != nil)
		build_tree(node.child_4) if (node.child_4 != nil)
		build_tree(node.child_5) if (node.child_5 != nil)
		build_tree(node.child_6) if (node.child_6 != nil)
		build_tree(node.child_7) if (node.child_7 != nil)
		build_tree(node.child_8) if (node.child_8 != nil)
	end

	def bfs
		queue = []
		queue << @root
		until queue.empty?
			return queue[0] if queue[0].value == @destination
			queue << queue[0].child_1  unless queue[0].child_1 == nil
			queue << queue[0].child_2  unless queue[0].child_2 == nil
			queue << queue[0].child_3  unless queue[0].child_3 == nil
			queue << queue[0].child_4  unless queue[0].child_4 == nil
			queue << queue[0].child_5  unless queue[0].child_5 == nil
			queue << queue[0].child_6  unless queue[0].child_6 == nil
			queue << queue[0].child_7  unless queue[0].child_7 == nil
			queue << queue[0].child_8  unless queue[0].child_8 == nil 
			queue = queue[1..-1]
		end
		return nil
	end

	def knight_moves(position, destination)
		@root = Node.new(position)
		@destination = destination
		build_tree
		node = bfs
		p "You made it in #{node.traversed.length} moves! Here's your path: "
		node.traversed.reverse.each { |square| p square }
		print "\n\n\n\n\n"
	end
end
check = Knight.new

start = []
finish = []
print "starting position: "
x = gets.chomp.split
x.each { |k| start << k.to_i }
print "finishing position: "
x = gets.chomp.split
x.each { |k| finish << k.to_i }

system 'clear'
puts ">knight_moves(#{start},#{finish})"

check.knight_moves(start,finish)