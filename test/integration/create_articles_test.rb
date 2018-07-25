require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
   
    def setup
        @user = User.create(
            username: "username", 
            email: "username@email.com", 
            password: "password", 
        )
    end
   
   test "get new article form and create an article" do
        
        sign_in_as(@user, "password")
        
        get new_article_path
        assert_template 'articles/new'
       
        assert_difference 'Article.count', 1 do
            post articles_path, params: {article: {
                title: "Test article",
                description: "This is the descritpion of an article",
                user: @user
            }}
            follow_redirect!
        end
        assert_template 'articles/show'
        assert_select 'div.alert-success'
        assert_match "Test article", response.body
    end
    
    test "invalid article submission should result in failure" do
        
        sign_in_as(@user, "password")
        
        get new_article_path
        assert_template 'articles/new'
       
        assert_no_difference 'Article.count' do
            post articles_path, params: {article: {
                title: "Test article",
                description: "invalid",
                user: @user
            }}
        end
        assert_template 'articles/new'
        assert_select 'div.alert-danger'
        assert_select 'h5.alert-heading'
    end
end