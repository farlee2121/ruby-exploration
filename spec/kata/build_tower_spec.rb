# def towerBuilder(n_floors)
#     total_width = ((n_floors - 1) * 2) + 1
#     floors = []
#     for floor in (1..n_floors) do
#         floor_width = ((floor - 1) * 2) + 1
#         spacer_width = (total_width - floor_width) / 2
#         spacer = " "*spacer_width
#         floors.append(spacer + "*"*floor_width + spacer)
#     end
#     return floors

#   end

def towerBuilder(n)
    (1..n).map do |i|
        space = ' ' * (n - i)
        stars = '*' * (i * 2 - 1)
        space + stars + space
    end
end

RSpec.describe "Tower Builder Kata" do
    it "should test for something" do
      expect(towerBuilder(1)).to eq(['*'])
      expect(towerBuilder(2)).to eq([' * ', '***'])
      expect(towerBuilder(3)).to eq(['  *  ', ' *** ', '*****'])
    end
  end