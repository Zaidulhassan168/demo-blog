# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# include InParallel

require 'ffaker'
require 'faker'

puts 'Creating users...'

def testThread
  t1 = Thread.new { 10.times { |_i| puts "t1 #{_i} #{generate_users}" } }
  t2 = Thread.new { 10.times { |_i| puts "t2 #{_i} #{generate_users}" } }
  t3 = Thread.new { 10.times { |_i| puts "t3 #{_i} #{generate_users}" } }
end

# Thread.new { generate_users }
# Thread.new { generate_users }
# Thread.new { generate_users }
# Thread.new { generate_users }

# def generate_users1
#   100.times do
#     User.create(
#       username: FFaker::Name.unique.name,
#       email: FFaker::Internet.unique.email,
#       password: FFaker::Internet.password(min_length: 8, max_length: 16)
#     )
#   end
# end

def generate_users
  Thread.new do
  100.times do
    username = FFaker::Name.name
    email = FFaker::Internet.email
    password = '112233'
    User.create(
      username:,
      email:,
      password:
    )
    puts "Created user #{username}"

    userName = email
    Thread.new do
      100.times do
        Thread.new do
        title = FFaker::Vehicle.make
        content = FFaker::Lorem.paragraph
        Post.create(
          title:,
          content:,
          userName:
        )
        sleep 1
        puts "Created post #{title}"
      end
      sleep 1
      end
    end
  end
end
end