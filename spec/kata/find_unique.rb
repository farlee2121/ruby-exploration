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


describe "Solution" do
    it "should test for something" do
      Test.assert_equals(find_uniq([1,1,1,1,0]), 0)
      Test.assert_equals(find_uniq([ 1, 1, 1, 2, 1, 1 ]), 2);
      Test.assert_equals(find_uniq([ 0, 0, 0.55, 0, 0 ]), 0.55);
    end
  end