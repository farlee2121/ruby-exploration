
  def endsWith(str, ending)
    str.end_with? ending
  end
  
  RSpec.describe "String ends with" do
    it "should pass sample tests" do
      expect(endsWith('abcde', 'cde')).to eq(true)
      expect(endsWith('abcde', 'abc')).to eq(false)
      expect(endsWith('abcde', '')).to eq(true)
    end
  end
