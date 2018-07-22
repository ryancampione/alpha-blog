require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
    
    def setup
        @category = Category.create(name: "Sports") 
        
        # create an admin user
        @user = User.create(
            username: "username", 
            email: "username@email.com", 
            password: "password", 
            admin: true
        )
    end
    
    test "should get categories index" do
        get categories_path
        assert_response :success
    end
    
    test "should get new" do
        
        # sign in as admin user
        sign_in_as(@user, "password")
        
        get new_category_path
        assert_response :success
    end
    
    test "should get show" do
        get category_path(@category)
        assert_response :success
    end
    
    test "new category should redirect non admin users" do
        assert_no_difference 'Category.count' do
            post categories_path, params: {category: {name: "Sports"}} 
                
        end
        assert_redirected_to categories_path
    end
    
    
end