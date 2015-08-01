class User
  attr_accessor :last_name, :birth_date, :address
  attr_reader :age, :id
  attr_writer :age
  @@users = []

  def self.all
    @@users
  end

  def self.count
    @@users.count
  end

  def self.find(id)
    @@users.find { |user| user.id == id }
  end

  def self.find_by(attribute, value)
    return [] unless value
    @@users.find_all { |user| user.send(attribute) == value }
  end

  def first_name=(value)
    @first_name = value
  end

  def first_name
    @first_name
  end

  def save
    validate_first_name
    @id = @@users.count + 1
    @@users << self
  end

  def destroy
    @@users.delete(self)
  end

  private
  def validate_first_name
    if first_name.class != String || first_name == "" || first_name.delete(' ').size < 3
      raise "Invalid value for first_name"
    end
  end
end