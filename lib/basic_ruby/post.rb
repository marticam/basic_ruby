class Post < Base
  attr_accessor :title, :description, :user, :comments

  @@posts = []

  def self.collection
    @@posts
  end

  def validations
    [:validates_presence_of_user]
  end

  private
  def validates_presence_of_user
    raise "Invalid value for user" if user.nil? || user.id.nil?
  end
end