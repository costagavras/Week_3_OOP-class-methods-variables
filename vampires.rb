
class Vampire

  @@coven_of_vampires = []

  def initialize(name, age)
    @name = name
    @age = age
    @in_coffin = true
    @drank_blood_today = false
  end

  def self.create(name, age)
    # creates a new vampire and adds it to the coven
    new_vampire = Vampire.new(name, age)
    @@coven_of_vampires << new_vampire
    return new_vampire
  end

  # setters

  def drink_blood
    # sets a vampire's drank_blood_today boolean to true

    # @@coven_of_vampires.delete(self)
    @drank_blood_today = true
    # @@coven_of_vampires << self
  end

  def go_home
    # sets a vampire's in_coffin boolean to true
    @in_coffin = true
  end

  def not_drink_blood
    @drank_blood_today = false
  end

  def go_out
    # sets a vampire's in_coffin boolean to true
    @in_coffin = false
  end

  # getters

  def out_of_coffin
    @in_coffin
  end

  def drank_blood_today
    @drank_blood_today
  end

  def self.sunrise
    # removes from the coven any vampires who are out of their coffins or who haven't drank any blood in the last day
    @@coven_of_vampires.reverse.each do |vampire|
        if vampire.out_of_coffin == false && vampire.drank_blood_today == false #needed getters to get back state of instance vampire in array coven_of_vampires
            @@coven_of_vampires.delete(vampire)
        end
    end
  end

  def self.sunset
    # sets drank_blood_today and in_coffin to false for the entire coven as they go out in search of blood
    @@coven_of_vampires.each do |vampire|
        vampire.not_drink_blood
        vampire.go_out
    end
  end

  def self.coven_of_vampires
    return @@coven_of_vampires
  end

end

puts Vampire.coven_of_vampires.inspect
jim = Vampire.create("Jim", 50)
humphrey = Vampire.create("Humphrey", 52)
bernard = Vampire.create("Bernard", 38)
puts Vampire.coven_of_vampires.inspect
puts Vampire.sunset
puts Vampire.coven_of_vampires.inspect
humphrey.go_home
puts Vampire.coven_of_vampires.inspect
puts Vampire.sunrise
puts Vampire.coven_of_vampires.inspect
