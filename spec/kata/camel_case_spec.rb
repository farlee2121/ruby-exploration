
#Complete the solution so that the function will break up camel casing, using a space between words.

# could have used a regex sub like: string.gsub(/(?=[A-Z])/, ' ')


def camelCaseSplit(string)
    # complete the function
    string.chars.reduce([]) { |agg, char| 
        case char 
        when "A".."Z" then agg.concat([" ", char])
        else agg.append(char)
        end
    }.join
end

RSpec.describe "Camel Case" do
    it "Test 1" do
        expect(camelCaseSplit('camelCasing')).to eq('camel Casing')
    end
    it "Test 2" do
        expect(camelCaseSplit('camelCasingTest')).to eq('camel Casing Test')
    end
end
