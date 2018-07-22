require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
   
    def setup
        @category1 = Category.create(name: "Sports")
        @category2 = Category.create(name: "Technology")
        @category3 = Category.create(name: "Music")
    end
    
    test "should show categories listing" do
        get categories_path
        assert_template 'categories/index'
        
         assert_select "a[href=?]",category_path(@category1), @category1.name
         assert_select "a[href=?]",category_path(@category2), @category2.name
         assert_select "a[href=?]",category_path(@category3), @category3.name
    end
end