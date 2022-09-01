require 'rails_helper'
RSpec.describe User, type: :model do
  it 'has a valid email' do
    user = User.new(name: 'John', email: 'zaid@')
    expect user.valid? == false
  end
  it 'has a valid password' do
    user = User.new(name: 'John', email: 'zaid@gmail.com', password: '123888eeee')
    expect(user).to be_valid
  end
  it 'has a valid username' do
     
    user = User.new(username: 'John', email: 'zaid@gmail.com', password: '1232222')
    expect(user).to be_valid
  end
  it 'has a unique email' do
    user = User.new(username: 'zaidul', email: 'zaid@gmail.com', password: '123456')
    expect(user).to be_valid
  end
end
