require 'rails_helper'
RSpec.describe User, type: :model do
  it 'has a valid email' do
    user = User.new(name: 'John', email: 'zaid@')
    expect user.valid? == false
  end
  it 'has a valid password' do
    user = User.new(name: 'John', email: 'zaid', password: '123')
    expect user.valid? == true
  end
  it 'has a valid username' do
    user = User.new(name: 'John', email: 'zaid@gmail.com', password: '1232222', username: '')
    expect(user).to be_valid
  end
end
