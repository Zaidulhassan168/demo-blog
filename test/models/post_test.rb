require "test_helper"

class PostTest < ActiveSupport::TestCase
 test " post should not have empty title" do
    post = Post.new
    assert post.invalid?
    assert post.errors[:title].any?
 end
  
 test " post should not have empty body" do

      post = Post.new title: "Test title", content: ""
      assert post.invalid?
      assert post.errors[:body].any?
 end
  test " post should not have empty title and body" do
      post = Post.new(title: "thetre u go", content: "hello how ar eyou doing")
      assert (post.valid?  )
      assert_not post.errors[:title].any? " thetre u go"
      assert post.errors[:title].any?
      assert post.errors[:body].any?
 end

 test " post should have title and body" do
      post = Post.new title: "thetre u go", content: "hello how ar eyou doing"
      assert post.valid?
 end
  
end
