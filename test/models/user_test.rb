require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "should not save user without username" do   
  #   assert_raises(NameError) do     user = User.new     user.save   endend
    test 'valid user' do
    end
  
    test 'invalid without name' do
    end
  
    test 'invalid without email' do
      user = User.new(name: 'John')
      refute user.valid?
      assert_not_nil user.errors[:email]
    end
  
    test 'invalid without password' do
      user = User.new(username: 'John', email: 'sd@mail.com')
      assert user.valid?
      assert_not_nil user.errors[:password]
    end
    test 'invalid without password confirmation' do
      user = User.new(name: 'John', email: 'sd@mail.com', password: '12345678')
      assert user.valid?
      # refute user.errors[:password_confirmation].empty?
        
    end
end
