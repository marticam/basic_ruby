require 'spec_helper'

describe Post do
 before(:each) do
    Post.class_variable_set(:@@posts, [])

    @user = User.new
    @user.first_name = "Jose"
    @user.save
  end

  describe 'instance methods' do
    it "sets the title" do
      post = Post.new
      post.title = "New Cars"

      expect(post.title).to eq "New Cars"
    end

    it "sets the description" do
      post = Post.new
      post.description = "Lorem ipsum...."

      expect(post.description).to eq "Lorem ipsum...."
    end

    it 'saves the post instance into the @@posts array' do
      post = Post.new
      post.title = "New Cars"
      post.user = @user
      expect(Post.count).to eq 0
      post.save
      expect(post.id).to eq 1
      expect(Post.count).to eq 1
    end

    it 'removes the post instance from the @@posts array' do
      post = Post.new
      post.title = "New Cars"
      post.user = @user
      post.save
      expect { post.destroy }.to change(Post, :count).by(-1)
    end

    it 'should not save a post without a user' do
      post = Post.new
      post.title = "New Cars"
      post.description = "Lorem ipsum...."

      expect { post.save }.to raise_error(RuntimeError)
    end
  end

  describe 'class methods' do
    it 'returns an array with all posts' do
      post = Post.new
      post.title = "New Cars"
      post.user = @user
      post.save

      expect(Post.all).to eq [post]
    end

    it 'finds the post with the given id' do
      post = Post.new
      post.title = "New Cars"
      post.user = @user
      post.save

      post2 = Post.new
      post2.title = "New Cars2"
      post2.user = @user
      post2.save

      expect(Post.find(post2.id)).to eq post2
    end

    it 'finds all posts with the given title' do
      post = Post.new
      post.title = "New Cars"
      post.user = @user
      post.save

      post2 = Post.new
      post2.title = "New Cars2"
      post2.user = @user
      post2.save

      post3 = Post.new
      post3.title = "New Cars"
      post3.user = @user
      post3.save

      expect(Post.find_by(:title, "New Cars")).to eq [post, post3]
    end
  end
end