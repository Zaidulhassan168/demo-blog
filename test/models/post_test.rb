require "test_helper"

class PostTest < ActiveSupport::TestCase
 test " post should not have empty title" do
    post = Post.new
    assert post.invalid?
    assert post.errors[:title].any?
 end
  
end
