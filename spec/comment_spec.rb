require 'spec_helper'

describe Comment do
  before do
    User.class_variable_set(:@@users, [])
    Post.class_variable_set(:@@posts, [])
    Comment.class_variable_set(:@@comments, [])

    @user = User.new
    @user.first_name = "Francisco"
    @user.last_name = "Rojas"
    @user.save

    @post = Post.new
    @post.title = "New Post"
    @post.description = "Lorem ipsum..."
    @post.user = @user
    @post.save
  end

  describe 'instance methods' do
    it 'belongs a user' do
      comment = Comment.new
      comment.user = @user

      expect(comment.user).to eq @user
    end

    it 'belongs to a post' do
      comment = Comment.new
      comment.post = @post

      expect(comment.post).to eq @post
    end

    it 'has a text' do
      expect(Comment.new).to respond_to :text
    end

    it 'saves the comment instance into the @@comments array' do
      comment = Comment.new
      comment.text = "Lorem ipsum..."
      comment.user = @user
      comment.post = @post
      expect(Comment.count).to eq 0

      comment.save
      expect(comment.id).to eq 1
      expect(Comment.count).to eq 1
    end

    it 'removes the comment instance from the @@comments array' do
      comment = Comment.new
      comment.text = "Lorem ipsum..."
      comment.user = @user
      comment.post = @post
      comment.save

      expect { comment.destroy }.to change(Comment, :count).by(-1)
    end

    it 'should not save a comment without a user' do
      comment = Comment.new
      comment.text = "Lorem ipsum..."
      comment.post = @post

      expect { comment.save }.to raise_error(RuntimeError)
    end

    it 'should not save a comment without a post' do
      comment = Comment.new
      comment.text = "Lorem ipsum..."
      comment.user = @user

      expect { comment.save }.to raise_error(RuntimeError)
    end
  end

  describe 'class methods' do
    it 'returns an array with all comments' do
      comment = Comment.new
      comment.text = "Lorem ipsum"
      comment.user = @user
      comment.post = @post
      comment.save

      expect(Comment.all).to eq [comment]
    end

    it 'finds the comment with the given id' do
      comment = Comment.new
      comment.text = "Lorem ipsum"
      comment.user = @user
      comment.post= @post
      comment.save

      comment2 = Comment.new
      comment2.text = "Lorem ipsum"
      comment2.user = @user
      comment2.post= @post
      comment2.save

      expect(Comment.find(comment2.id)).to eq comment2
    end

    it 'finds all comments with the given title' do
      comment = Comment.new
      comment.text = "Lorem"
      comment.user = @user
      comment.post = @post
      comment.save

      comment2 = Comment.new
      comment2.text = "Lorem ipsum"
      comment2.user = @user
      comment2.post = @post
      comment2.save

      comment3 = Comment.new
      comment3.text = "Lorem ipsum"
      comment3.user = @user
      comment3.post = @post
      comment3.save

      expect(Comment.find_by(:text, "Lorem ipsum")).to eq [comment2, comment3]
    end
  end
end