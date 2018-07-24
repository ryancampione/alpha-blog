require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
    
    def setup
        # create an admin user
        @user = User.create(
            username: "username", 
            email: "username@email.com", 
            password: "password", 
            admin: true
        )
        
        @article = Article.create(
            title: "Test Article", 
            description: "This is a test description for the article",
            user: @user
        ) 
        
    end
    
    test "should get article index" do
        get articles_path
        assert_response :success
    end
    
    test "should get new" do
        
        # sign in as admin user
        sign_in_as(@user, "password")
        
        get new_article_path
        assert_response :success
    end
    
    test "should get show" do
        get article_path(@article)
        assert_response :success
    end
    
end