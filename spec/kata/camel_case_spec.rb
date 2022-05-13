
#Complete the solution so that the function will break up camel casing, using a space between words.

# could have used a regex sub like: string.gsub(/(?=[A-Z])/, ' ')

def solution(string)
    # complete the function
     string.chars.reduce([]) { |agg, char| 
        case char 
        when "A".."Z" then agg.concat([" ", char])
        else agg.append(char)
        end
      }.join
  end

RSpec.describe "Example Tests" do
    it "Test 1" do
        expect(solution('camelCasing')).to eq('camel Casing')
    end
    it "Test 2" do
        expect(solution('camelCasingTest')).to eq('camel Casing Test')
    end
  end