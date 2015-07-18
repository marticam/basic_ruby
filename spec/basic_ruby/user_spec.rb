require 'spec_helper'

describe BasicRuby::User do
  before(:each) do
    BasicRuby::User.class_variable_set(:@@users, [])
  end
  describe 'instance methods' do
    it 'creates an instance of User class' do
      expect(BasicRuby::User.new.class).to be BasicRuby::User
    end

    it 'sets the name for a user' do
      user = BasicRuby::User.new
      user.name = "Ruby"
      expect(user.name).to eq "Ruby"
    end

    it 'sets the last name for a user' do
      user = BasicRuby::User.new
      user.last_name = "Language"
      expect(user.last_name).to eq "Language"
    end

    it 'should respond to #id' do
      user = BasicRuby::User.new
      expect(user.respond_to?(:id)).to be true
    end

    it 'should not respond to #id=' do
      user = BasicRuby::User.new
      expect(user.respond_to?(:id=)).to be false
    end

    it 'should save the user and assign an id to it' do
      user = BasicRuby::User.new
      user.save
      expect(user.id).to eq 1
    end

    it 'should destroy the user with the given id' do
      user1 = BasicRuby::User.new
      user1.save

      user2 = BasicRuby::User.new
      user2.save
      expect(user1.destroy).to eq true
    end

    it 'should decrease the users count by 1' do
      user1 = BasicRuby::User.new
      user1.save

      user2 = BasicRuby::User.new
      user2.save
      expect(BasicRuby::User.count).to eq 2
      expect { user1.destroy }.to change(BasicRuby::User, :count).by(-1)
    end
  end

  describe 'class methods' do
    it 'should increase user count by 1 after saving a user' do
      user = BasicRuby::User.new
      expect { user.save }.to change(BasicRuby::User, :count).by(1)
    end

    it 'should return an array of all users' do
      wolfgang = BasicRuby::User.new
      wolfgang.name = 'Wolfgang'
      wolfgang.last_name = 'Mozart'
      wolfgang.save

      bach = BasicRuby::User.new
      bach.name = 'Johann'
      bach.last_name = 'Bach'
      bach.save

      expect(BasicRuby::User.all.count).to eq 2
      expect(BasicRuby::User.all).to eq [wolfgang, bach]
    end
  end
end