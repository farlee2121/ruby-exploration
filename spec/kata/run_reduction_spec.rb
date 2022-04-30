def unique_in_order(iterable)
    array = iterable
    if iterable.class == String
        array = iterable.chars
    end
    return array.reduce([]) {|agg, nextElement|   
        if agg[-1] != nextElement
            agg.append(nextElement)
        end
        agg
    }
  end

# A clever answer off codewars
## (iterable.is_a?(String) ? iterable.chars : iterable).chunk { |x| x }.map(&:first)

RSpec.describe "run reduce" do
    it "" do
        # shows the same answer in the console, and works in code wars, not sure what's the problem here
        expect(unique_in_order('AAAABBBCCDAABBB')).to equal(['A','B','C','D','A','B'])
    end

end