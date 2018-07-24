require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
    
    def setup
        @user = User.create(
            username: "username",
            email: "test@email.com",
            password: "password"
        )
        
        @article = Article.new(
            title: "Test Article",
            description: "This is a test description",
            user: @user
        )
    end
    
    test "article shoud be valid" do
        assert @article.valid?
    end
    
    test "title should be present" do
        @article.title = nil
        assert_not @article.valid?
    end
    
    test "title should not be too long" do
        @article.title = "a" * 51
        assert_not @article.valid?
    end
    
    test "title shoud not be too short" do
        @article.title = "a" * 2
        assert_not @article.valid?
    end

    test "description should be present" do
       @article.description = nil 
       assert_not @article.valid?
    end

    test "description shoud not be too short" do
        @article.description = "a" * 9
        assert_not @article.valid?
    end

    test "description should not be too long" do
        @article.description = "a" * 301
        assert_not @article.valid?
    end
    
    test "user should be present" do
       @article.user_id = nil
       assert_not @article.valid?
    end
end