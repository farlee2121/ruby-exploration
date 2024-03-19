
Point = Struct.new(:x, :y)
def add_direction_unit(coordinate, direction)
    case direction
        when "n" then coordinate.y += 1
        when "s" then coordinate.y -= 1
        when "e" then coordinate.x += 1
        when "w" then coordinate.x -= 1
    end
    return coordinate
end

def is_valid_walk(walk)
    #your code here
    if walk.length() != 10
        return false
    else
        finalPoint = walk.reduce(Point.new(0, 0)) {|agg, nextDir| add_direction_unit(agg, nextDir) }
        return Point.new(0, 0) == finalPoint
    end
  end


RSpec.describe "Random Walk" do
    it "should pass sample tests" do
        expect(is_valid_walk(['n','s','n','s','n','s','n','s','n','s'])).to be true;
        expect(is_valid_walk(['w','e','w','e','w','e','w','e','w','e','w','e'])).to be false;
        expect(is_valid_walk(['w'])).to be false;
        expect(is_valid_walk(['n','n','n','s','n','s','n','s','n','s'])).to be false;
    end
end
  