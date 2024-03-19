def likes(names)
    case names.length
    when 0 
        'no one likes this'
    when 1
        "#{names[0]} likes this"
    when 2
        "#{names[0]} and #{names[1]} like this"
    when 3
        "#{names[0]}, #{names[1]} and #{names[2]} like this"
    else 
        "#{names[0]}, #{names[1]} and #{names.length - 2} others like this"
    end
  end


describe 'Basic tests' do
    it "Testing" do
      expect(likes([])).to  eq('no one likes this')
      expect(likes(['Peter'])).to eq('Peter likes this')
      expect(likes(['Jacob', 'Alex'])).to eq('Jacob and Alex like this')
      expect(likes(['Max', 'John', 'Mark'])).to eq('Max, John and Mark like this')
      expect(likes(['Alex', 'Jacob', 'Mark', 'Max'])).to eq('Alex, Jacob and 2 others like this')
    end
end