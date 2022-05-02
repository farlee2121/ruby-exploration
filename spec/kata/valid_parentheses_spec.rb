# other codewars solutions pointed out that I can replace the separate counts with one and just make sure the count never goes negative and ends as zero
ParenCount = Struct.new(:openCount, :closeCount)

def valid_parentheses(string)
    counts = string.chars.reduce([ParenCount.new(0,0)]) {|agg, char|
        nextCount = agg.last.clone
        case char
        when "("
            nextCount.openCount += 1
        when ")"
            nextCount.closeCount += 1
        end
        agg.append(nextCount)
    }

    finalCount = counts.last
    is_balanced = finalCount.openCount == finalCount.closeCount
    is_well_ordered = !counts.find {|count| count.openCount < count.closeCount}
    return is_balanced && is_well_ordered
  end


RSpec.describe "valid parentheses" do
    it "codewars tests" do
        expect(valid_parentheses("  (")).to eq(false)
        expect(valid_parentheses(")test")).to eq(false)
        expect(valid_parentheses("")).to eq(true)
        expect(valid_parentheses("hi())(")).to eq(false)
        expect(valid_parentheses("hi(hi)()")).to eq(true)
        expect(valid_parentheses(")(")).to eq(false)
    end
end 