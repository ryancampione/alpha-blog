require 'test_helper'

class UserSignUpTest < ActionDispatch::IntegrationTest
   
    test "user should sign up for new profile" do
        get signup_path
        assert_template 'users/new'
        
        assert_difference 'User.count', 1 do
            post users_path, params: {user: {
                username: "username",
                email: "username@email.com",
                password: "password"
            }}
            follow_redirect!
        end

        assert_template 'users/show'
        assert_select 'div.alert-success'
    end
    
    test "invalid user sign up should result in failure" do
        get signup_path
        assert_template 'users/new'
        
        assert_no_difference 'User.count' do
            post users_path, params: {user: {
                username: "username",
                email: "username@email.com",
                password: "invalid"
            }}
        end

        assert_template 'users/new'
        assert_select 'div.alert-danger'
        assert_select 'h5.alert-heading'
    end
end