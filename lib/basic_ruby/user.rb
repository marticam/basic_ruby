module BasicRuby
  class User
    attr_accessor :last_name
    attr_reader :id
    @@users = []

    def self.count
      @@users.count
    end

    def self.all
      @@users
    end

    def name
      @name
    end

    def name=(value)
      @name = value
    end

    def save
      @id = @@users.count + 1
      @@users << self
      true
    end

    def destroy
      user_id = self.id
      # if user has an id is because it has been saved already
      if user_id
        @@users.delete_if { |user| user.id == user_id }
        true
      else
        false
      end
    end
  end
end