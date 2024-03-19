def title_case(title, minor_words = '')
    words = title.split(" ")
    minor_words = minor_words.split.map(){|str| str.downcase}
    
    if(words.length() > 0)
      head, *tail = words
      return [
        head.capitalize,
        tail.map(){|word| if minor_words.include?(word.downcase) then word.downcase else word.capitalize end}
      ].flatten.join(" ")
    else
      return title
    end
    
  end



RSpec.describe "Title Case" do
    it "should pass sample tests" do
      expect(title_case('')).to eq('')
      expect(title_case('a clash of KINGS', 'a an the of')).to eq('A Clash of Kings')
      expect(title_case('THE WIND IN THE WILLOWS', 'The In')).to eq('The Wind in the Willows')
      expect(title_case('the quick brown fox')).to eq('The Quick Brown Fox')
      expect(title_case('         ')).to eq('         ')
    end
end