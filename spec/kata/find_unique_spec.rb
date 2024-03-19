def find_uniq(arr)
    frequencies = Hash.new
    for x in arr do 
        if frequencies[x] 
            frequencies[x] += 1
        else
            frequencies[x] = 1 
        end
    end
    return frequencies.keys.find {|n| frequencies[n] == 1}
end

# def find_uniq(arr)
#     arr.tally.key(1)
#   end


RSpec.describe "Find unique" do
    it "sample tests" do
      expect(find_uniq([1,1,1,1,0])).to eq(0)
      expect(find_uniq([ 1, 1, 1, 2, 1, 1 ])).to eq(2);
      expect(find_uniq([ 0, 0, 0.55, 0, 0 ])).to eq(0.55);
    end
  end