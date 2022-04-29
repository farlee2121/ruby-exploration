def solution(str, ending)
  str.end_with? ending
end

RSpec.describe "String ends with" do
    it "should pass sample tests" do
      expect(solution('abcde', 'cde')).to be true
      expect(solution('abcde', 'abc')).to be false
      expect(solution('abcde', '')).to be true
    end
end
  