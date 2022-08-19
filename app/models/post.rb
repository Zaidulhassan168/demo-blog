class PostCallbacks
  def self.after_create(post)
    Post.show(post.title, post.content)
  end
end

class Post < ApplicationRecord
  attr_accessor :user_email

  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }

  
  after_create PostCallbacks

  def self.show(title, content)
    puts "Title: #{title}"
    puts "Cent: #{content}"
    # puts "user: #{Current.user.id}"
    puts '-----------------------------------------'
  end
   
end
