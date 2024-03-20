## How I do this?           
## I could create a separate matrix and go in a direction until i hit the end or a visited node, then change direction, but that seems overly complex
## Q: is there a pattern in how far I have to travel
## - all matrices are square
## - 1x1 -> no travel;  2x2 -> 1 right, 1 down, 1 left;  3x3 -> 3 right, 2 down, 2 left, 1 up, 1 right;  4x4 -> 4 right, 3 down, 3 left, 2 up, 2 right, 1 down, 1 left
## - 5x5 -> 5r, 4d, 4l, 3u, 3r, 2d, 2l, 1u, 1r
## - I notice, other than 2x2, there's never more than 2 moves of the same magnitude before it decreases. In fact, other than the first move it is always two moved then a decrease.
##   this makes sense because after two moves you're turning back in a direction you've previously visited.
## - The number of moves is also predictable because we visit every node exactly once. 
## It'd be easier to loop if there was a nice way to calculate the magnitude of movement based on visit index. Is there one?
## - n - (i/2).ceil? 2x2 -> 0 -> 2, 1 -> 1, 2 -> 1 3x3 thats 3 - (0/2).ceil = 3, 1 -> 2, 2 -> 2, 3 -> 1 ->, 4 -> 1, 5 -> 0. But this is wrong, it's based on the move index, not the node index. That's fine if I find a way to calculate the number of moves
## Q: number of moves equation?
## - 1x1 -> 0 ; 2x2 -> 3 ; 3x3 -> 5 ; 4 x 4 -> 7 ; 5 x 5 -> 9
## - appears to be 3 + ((n-2)*2) for n >= 2  

## with these new calculations, I could also calculate direction based on move index and make the whole thing mutation-free, just a functional-style map

## I'm pretty sure my solution isn't what they're looking for, but it taught me a lot (how to define constants in ruby, reducing, hash/dictionary)

# class Directions
#     class << self 
#         RIGHT = "right"
#         LEFT = "left"
#         UP = "up"
#         DOWN = "down"
#     end
# end

# module Directions
#     class RIGHT; end 
#     class LEFT; end 
#     class UP; end 
#     class DOWN; end
# end

module Directions
    RIGHT = "right"
    LEFT = "left"
    UP = "up"
    DOWN = "down"
end

class Position

    def initialize(x, y)
        @x = x
        @y = y
    end

    def x
        return @x
    end

    def y 
        return @y
    end

    def move (direction, distance)
        return case direction
        when Directions::RIGHT
            Position.new(@x + distance, @y)
        when Directions::LEFT
            Position.new(@x - distance, @y)
        when Directions::DOWN
            Position.new(@x , @y + distance)
        when Directions::UP
            Position.new(@x, @y - distance)
        end
    end

    def travel (direction, distance, &handlePoint)
        return (0..distance).to_a.reduce(self) {|point,_| 
            handlePoint.call(point)
            point.move(direction, 1)
        }.move(direction, -1)
    end

end

def next_direction(direction)
    direction_order = [Directions::RIGHT, Directions::DOWN, Directions::LEFT, Directions::UP]
    current_index = direction_order.find_index(direction)
    return direction_order[(current_index + 1) % direction_order.length]
end

def snail(array)

    if(array.empty?) then return [] end
    if(array.length == 1) then return array[0] end
    
    number_of_moves = 3 + ((array.length-2)*2)

    traversed = []
    current_position = Position.new(0,0)
    current_direction = Directions::RIGHT
    for move_index in (0..number_of_moves-1) do
        magnitude = array.length - (move_index/2.to_f).ceil - 1
        final_covered = current_position.travel(current_direction, magnitude){|point| traversed.append(array[point.y][point.x])}
        current_direction = next_direction(current_direction)
        ## Other than the first move, we don't want to cover the node the last moved ended on / already covered
        current_position = final_covered.move(current_direction, 1)
    end

    return traversed
  end

RSpec.describe "Snail" do
    it "Sample Tests" do
        expect(snail([[1,2,3],[4,5,6],[7,8,9]])).to eq([1, 2, 3, 6, 9, 8, 7, 4, 5])
        expect(snail([[1,2],[3,4]])).to eq([1, 2, 4, 3])
        expect(snail([[1]])).to eq([1])
        expect(snail([[]])).to eq([])
    end
end

