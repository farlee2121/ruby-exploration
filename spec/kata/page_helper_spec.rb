# TODO: complete this class
class PaginationHelper
  
    # The constructor takes in an array of items and a integer indicating how many
    # items fit within a single page
    def initialize(collection, items_per_page)
        @items = collection
        @page_size = items_per_page
    end
    
    # returns the number of items within the entire collection
    def item_count
        return @items.length
    end
      
    # returns the number of pages
    def page_count
      return (self.item_count / @page_size.to_f).ceil
    end
      
    # returns the number of items on the current page. page_index is zero based.
    # this method should return -1 for page_index values that are out of range
    def page_item_count(page_index)
      if (@items.empty? && page_index == 0)
        return 0
      elsif(page_index < 0 || self.page_count <= page_index)
        return -1
      else
        isLastPage = (page_count - 1) == page_index
        return isLastPage ? (item_count - (@page_size * page_index)): @page_size
      end
    end

    # determines what page an item is on. Zero based indexes.
    # this method should return -1 for item_index values that are out of range
    def page_index(item_index) 
        if(item_index < 0 || self.item_count <= item_index || @items.empty?)
            return -1
        else
            return (item_index / @page_size.to_f).floor
        end
    end
end


# Q: How can I add create new assertions for RSpec?
# - Expect doesn't appear to be a child of RSpec (i.e. Rspec.expect). 
# - for that matter, I can't even figure out how RSpec is getting loaded / imported
# - https://rspec.info/features/3-12/rspec-expectations/custom-matchers/define-matcher/
# - https://stackoverflow.com/questions/38991873/can-i-use-a-built-in-rspec-matcher-in-a-custom-matcher
# - Maybe I just don't understand ruby well enough, but the RSpec assertions seem excessively difficult to compose
# - expectation target appears to be the type I want, https://rspec.info/documentation/3.13/rspec-expectations/RSpec/Expectations/ExpectationTarget.html, but I still can't find where the method lives
# - what type does Rspec.describe return? or it?
#   - defined here supposedly https://github.com/rspec/rspec-core/blob/main/lib/rspec/core/dsl.rb#L15
#   - describe returns a RSpec::Core::ExampleGroup
#   - Test4 < RSpec::Core::ExampleGroup tells me that expect can only be called from individual examples like created with `it`
#   - What is the type of `it`? Writing a test and puts `self.class` tells me `RSpec::ExampleGroups::Anonymous_4`
#   - I'm about to bail and see how good MiniTest is... what a pain. There's way too much meta programming going on here.
#   - ok, I see now where the dsl methods are defined. they're all keys turned to methods with meta programming (i.e. :it, :describe) https://github.com/rspec/rspec-core/blob/1e661db5c5b431c0ee88a383e8e3767f02dccbfe/lib/rspec/core/example_group.rb#L161
#   - it should be a `RSpec::Core::Example`, but inheriting from that just tells me there's no expect method
#   - this is ridiculous. I've spent over an hour, maybe two, trying to figure out what should be a simple method wrapping

# class Test7 < RSpec::Core::Example
# include RSpec::Expectations
#   include RSpec::Matchers
#   def self.assert_equals(actual, expected)
#     expect(actual).to eq(expected)
#   end
# end



# From Ruby 3.0, RSpec is used under the hood.
# See https://rspec.info/
# Defaults to the global `describe` for backwards compatibility, but `RSpec.desribe` works as well.
RSpec.describe "Page Helper" do
    it "degenerate cases" do 
      paginator = PaginationHelper.new([1,2,3], 5)
      expect(paginator.page_item_count(-1)).to eq(-1)
      expect(paginator.page_item_count(1)).to eq(-1)
      expect(paginator.page_index(-1)).to eq(-1)
      expect(paginator.page_index(3)).to eq(-1)
    end
    it "empty collection" do
      paginator = PaginationHelper.new([], 5)
      expect(paginator.item_count).to eq(0)
      expect(paginator.page_count).to eq(0)
      expect(paginator.page_index(0)).to eq(-1)
      expect(paginator.page_item_count(0)).to eq(0)
      expect(paginator.page_item_count(1)).to eq(-1)
    end
    
    it "last page not full" do
      paginator = PaginationHelper.new([1,2,3,4,5], 2)
      expect(paginator.item_count).to eq(5)
      expect(paginator.page_count).to eq(3)
      expect(paginator.page_index(2)).to eq(1)
      expect(paginator.page_item_count(0)).to eq(2)
      expect(paginator.page_item_count(2)).to eq(1)
    end
    
    it "last page full" do
      paginator = PaginationHelper.new([1,2,3,4,5,6], 2)
      expect(paginator.item_count).to eq(6)
      expect(paginator.page_count).to eq(3)
      expect(paginator.page_index(2)).to eq(1)
      expect(paginator.page_item_count(0)).to eq(2)
      expect(paginator.page_item_count(2)).to eq(2)
    end
  end
  