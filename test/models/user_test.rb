require 'test_helper'

class UserTest < ActiveSupport::TestCase
    
    def setup
        @user = User.create(
            username: "username",
            email: "test@email.com",
            password: "password"
        )
    end
    
    test "user shoud be valid" do
        assert @user.valid?
    end
    
    test "username should be present" do
        @user.username = nil
        assert_not @user.valid?
    end
    
    test "username should not be too long" do
        @user.username = "a" * 26
        assert_not @user.valid?
    end
    
    test "username shoud not be too short" do
        @user.username = "a" * 2
        assert_not @user.valid?
    end
    
    test "username should not contain whitespace" do
        @user.username = "user name"
        assert_not @user.valid?
    end

    test "username should be unique" do
        @other_user = User.new(
            username: @user.username,
            email: "another@email.com",
            password: "password"
        )
       assert_not @other_user.valid?
    end

    test "email should be present" do
       @user.email = nil 
       assert_not @user.valid?
    end

    test "email should not be too long" do
        @user.email = "a" * 106
        assert_not @user.valid?
    end
    
    test "email should be valid format" do
       @user.email = "email.com"
       assert_not @user.valid?
    end
    
    test "email should be unique" do
        @other_user = User.new(
            username: "anotherUser",
            email: @user.email,
            password: "password"
        )
       assert_not @other_user.valid?
    end
    
    test "password should be present" do
        @user.password = nil
        assert_not @user.valid?
    end
    
    test "password should not be too short" do
       @user.password = "a" * 7
       assert_not @user.valid?
    end

end