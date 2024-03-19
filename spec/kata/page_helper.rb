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


# From Ruby 3.0, RSpec is used under the hood.
# See https://rspec.info/
# Defaults to the global `describe` for backwards compatibility, but `RSpec.desribe` works as well.
describe "Example" do

    it "degenerate cases" do 
      paginator = PaginationHelper.new([1,2,3], 5)
      Test.assert_equals(paginator.page_item_count(-1), -1)
      Test.assert_equals(paginator.page_item_count(1), -1)
      Test.assert_equals(paginator.page_index(-1), -1)
      Test.assert_equals(paginator.page_index(3), -1)
    end
    it "empty collection" do
      paginator = PaginationHelper.new([], 5)
      Test.assert_equals(paginator.item_count, 0)
      Test.assert_equals(paginator.page_count, 0)
      Test.assert_equals(paginator.page_index(0), -1)
      Test.assert_equals(paginator.page_item_count(0), 0)
      Test.assert_equals(paginator.page_item_count(1), -1)
    end
    
    it "last page not full" do
      paginator = PaginationHelper.new([1,2,3,4,5], 2)
      Test.assert_equals(paginator.item_count, 5)
      Test.assert_equals(paginator.page_count, 3)
      Test.assert_equals(paginator.page_index(2), 1)
      Test.assert_equals(paginator.page_item_count(0), 2)
      Test.assert_equals(paginator.page_item_count(2), 1)
    end
    
    it "last page full" do
      paginator = PaginationHelper.new([1,2,3,4,5,6], 2)
      Test.assert_equals(paginator.item_count, 6)
      Test.assert_equals(paginator.page_count, 3)
      Test.assert_equals(paginator.page_index(2), 1)
      Test.assert_equals(paginator.page_item_count(0), 2)
      Test.assert_equals(paginator.page_item_count(2), 2)
    end
  end
  