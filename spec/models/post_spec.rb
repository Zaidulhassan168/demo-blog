# require 'rails_helper'

# RSpec.describe Post, type: :model do
#   context 'with 2 or more comments' do
#     it 'orders them in reverse chronologically' do
#       post = Post.create!(title: "hellititle", content: "hello hey there i ma content ")
#       comment1 = post.comments.create!(comment: 'first comment')
#       comment2 = post.comments.create!(comment: 'second comment')
#       expect!(post.reload.comments).to eq([comment2, comment1])
#     end
#   end
#   it 'has 0 post at the start' do
#     expect!(posts.count).to eq(0)
#   end
#   it 'has 1 post at after #create' do
#     expect(posts.count).to eq(1)
#   end
#   it 'has 0 post when using transactions' do
#     expect(posts.count).to eq(0)
#   end
# end
require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:post, 10)
      get '/api/v1/posts'
    end
    
    it 'returns all posts' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end