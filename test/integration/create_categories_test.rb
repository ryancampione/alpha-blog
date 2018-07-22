require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
   
   test "get new category form and create category" do
        get new_category_path
        assert_template 'categories/new'
       
        assert_difference 'Category.count', 1 do
            post categories_path, params: {category: {name: "Sports"}} 
            follow_redirect!
        end
        assert_template 'categories/index'
        assert_match "Sports", response.body
    end
    
    test "invalid category submission should result in failure" do
        get new_category_path
        assert_template 'categories/new'
       
        assert_no_difference 'Category.count' do
            post categories_path, params: {category: {name: " "}} 
            
        end
        assert_template 'categories/new'
        assert_select 'div.alert-danger'
        assert_select 'h5.alert-heading'
    end
end