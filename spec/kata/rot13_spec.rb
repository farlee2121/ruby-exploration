# ROT13 is a simple letter substitution cipher that replaces a letter with the letter 13 letters after it in the alphabet.
#  ROT13 is an example of the Caesar cipher.

# Create a function that takes a string and returns the string ciphered with Rot13.
#  If there are numbers or special characters included in the string, they should be returned as they are.
#  Only letters from the latin/english alphabet should be shifted, like in the original Rot13 "implementation".

# apparently this is a valid solution
#    string.tr("A-Za-z", "N-ZA-Mn-za-m")


def rot13(string)
    lower_map = Hash[("a".."z").zip(("a".."z").to_a.rotate(13))]
    upper_map = Hash[("A".."Z").zip(("A".."Z").to_a.rotate(13))]
    cypher_map = lower_map.merge upper_map

    return string.chars.map {|char| if cypher_map[char] then cypher_map[char] else char end}.join
  end

RSpec.describe "Rot13" do
    it "test" do
      expect(rot13("test")).to eq("grfg")
    end    
    it "Test" do
      expect(rot13("Test")).to eq("Grfg")    
    end
  end