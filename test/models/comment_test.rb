require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "comment should not have empty body" do
    comment = Comment.new comment: "hwllooooo"
    assert comment.valid?  "hwllooooo"
    assert comment.errors[:body].any?
  end
end
                













