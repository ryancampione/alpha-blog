require 'test_helper'

class UpdateArticlesTest < ActionDispatch::IntegrationTest
   
    def setup
        @user = User.create(
            username: "username", 
            email: "username@email.com", 
            password: "password", 
        )
        
        @article = Article.create(
            title: "Test article",
            description: "This is the descritpion of an article",
            user: @user
        )
    end
   
  test "get edit article form and update the article" do
        
        sign_in_as(@user, "password")
        
        get edit_article_path(@article)
        assert_template 'articles/edit'
        
        assert_match @article.title, response.body
        assert_match @article.description, response.body
        
        patch article_path, params: {article: {
            id: @article.id,
            title: "Test article edited",
            description: "This is the descritpion of an edited article",
        }} 
        follow_redirect!

        assert_template 'articles/show'
        assert_select 'div.alert-success'
        assert_match "Test article edited", response.body
        assert_match "This is the descritpion of an edited article", response.body
    end
    
    test "invalid article submission should result in failure" do
        
        sign_in_as(@user, "password")
        
        get edit_article_path(@article)
        assert_template 'articles/edit'

        assert_no_difference 'Article.count' do
            patch article_path, params: {article: {
                id: @article.id,
                title: "Test article edited",
                description: "invalid",
            }}
        end
        
        assert_template 'articles/edit'
        assert_select 'div.alert-danger'
        assert_select 'h5.alert-heading'
    end
end