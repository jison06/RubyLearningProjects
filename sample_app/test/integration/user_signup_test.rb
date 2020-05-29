# frozen_string_literal: true

require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test 'Displays invalid messages when creating an invalid user' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '', email: 'user@invalid', password: '', password_confirmation: '' } }
    end
    assert_template 'users/new'
    assert_select 'div.alert.alert-danger', count: 1
    assert_select '.error-message', count: 5
  end

  test 'Creates a new valid user' do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: { name: 'test', email: 'user@example.com', password: 'foobar',
                                         password_confirmation: 'foobar' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.alert.alert-success'
  end
end
