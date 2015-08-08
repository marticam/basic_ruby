class User < Base
  attr_accessor :first_name,
                :last_name,
                :birth_date,
                :address,
                :age

  @@users = []

  def self.collection
    @@users
  end

  def posts
    Post.find_by(:user, self)
  end

  def validations
    [:validate_first_name]
  end

  private
  def validate_first_name
    if first_name.class != String || first_name == "" || first_name.delete(' ').size < 3
      raise "Invalid value for first_name"
    end
  end
end