require 'spec_helper'

describe User do
  before(:each) do
    User.class_variable_set(:@@users, [])
  end

  describe 'instance methods' do
    it "sets the first name" do
      user = User.new
      user.first_name = "Francisco"

      expect(user.first_name).to eq "Francisco"
    end

    it "sets the last name" do
      user = User.new
      user.last_name = "Rojas"

      expect(user.last_name).to eq "Rojas"
    end

    it "sets the age" do
      user = User.new
      user.age = 27

      expect(user.age).to eq 27
    end

    it 'saves the user instance into the @@users array' do
      user = User.new
      user.first_name = "Francisco"
      expect(User.count).to eq 0
      user.save
      expect(user.id).to eq 1
      expect(User.count).to eq 1
    end

    it 'removes the user instance from the @@users array' do
      user = User.new
      user.first_name = "Francisco"
      user.save
      expect { user.destroy }.to change(User, :count).by(-1)
    end

    it 'finds all user posts' do
      user = User.new
      user.first_name = "Jose"
      user.save

      user2 = User.new
      user2.first_name = "Francisco"
      user2.save

      10.times do |i|
        post = Post.new
        post.title = "Post #{i}"
        post.description = "Lorem ipsum...#{i}"
        post.user = i.even? ? user : user2
        post.save
      end
      expect(user.posts.size).to eq 5
      expect(user2.posts.size).to eq 5
    end
  end

  describe 'class methods' do
    it 'returns an array with all users' do
      user = User.new
      user.first_name = "Francisco"
      user.save

      expect(User.all).to eq [user]
    end

    it 'finds the user with the given id' do
      user = User.new
      user.first_name = "Jose"
      user.save

      user2 = User.new
      user2.first_name = "Francisco"
      user2.save

      expect(User.find(user2.id)).to eq user2
    end

    it 'finds all users with the given first_name' do
      user = User.new
      user.first_name = "Jose"
      user.save

      user2 = User.new
      user2.first_name = "Francisco"
      user2.save

      user3 = User.new
      user3.first_name = "Jose"
      user3.save

      expect(User.find_by(:first_name, "Jose")).to eq [user, user3]
    end
  end
end