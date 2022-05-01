def high_and_low(numbers)
    numberArray = numbers.split(" ").map(){|str| Integer(str)}
    return "#{numberArray.max()} #{numberArray.min()}"
  end

RSpec.describe "Example Tests" do
    it "Test 1" do
      expect(high_and_low("8 3 -5 42 -1 0 0 -9 4 7 4 -4")).to eq("42 -9")
    end
    it "Test 2" do
      expect(high_and_low("1 2 3")).to eq("3 1")
    end
  end