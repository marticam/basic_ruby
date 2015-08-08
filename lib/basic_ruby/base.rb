class Base
  attr_reader :id

  def self.count
    collection.count
  end

  def self.all
    collection
  end

  def self.find(id)
    collection.find { |record| record.id == id }
  end

  def self.find_by(attribute, value)
    return [] unless value
    collection.find_all { |record| record.send(attribute) == value }
  end

  def destroy
    self.class.collection.delete(self)
  end

  def save
    validations.each { |validation| self.send(validation) }
    @id = self.class.collection.count + 1
    self.class.collection << self
  end
end