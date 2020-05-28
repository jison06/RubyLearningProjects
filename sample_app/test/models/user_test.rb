# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'test_user', email: 'email@email.com', password: 'foobar', password_confirmation: 'foobar')
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'name cannot be empty' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'email cannot be empty' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name should not exceed length limit' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not exceed length limit' do
    @user.name = 'a' * 256
    assert_not @user.valid?
  end

  test 'email should be a valid address' do
    valid_emails = %w[email@example.com example@email.com user@example.com]

    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{@user.email.inspect} should be valid"
    end
  end

  test 'invalid emails should be a rejected' do
    invalid_emails = %w[email@example,com example@email .com user@examplecom]

    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{@user.email.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'emails should be saved as lower case' do
    mixed_case_email = 'tesT@ExaAmple.com'
    @user.email = mixed_case_email
    @user.save
    assert_equal @user.email, mixed_case_email.downcase
  end

  test 'passwords cannot be blank' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'passwords should meet length minumum' do
    @user.password = @user.password_confirmation = 'a*5'
    assert_not @user.valid?
  end
end
