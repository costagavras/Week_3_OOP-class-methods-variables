
class Zombie

  @@horde = []
  @@plague_level = 10
  @@max_speed = 5
  @@max_strength = 8
  @@default_speed = 1
  @@default_strength =  3

  def initialize(speed, strength)
    # If the speed argument is greater than @@max_speed then
    # @@default_speed should be used as the new zombie's speed instead.
    if speed > @@max_speed
      @speed = @@default_speed
    else
      @speed = speed
    end
    # make sure the strength argument is less than or equal to @@max_strength,
    # otherwise @@default_strength should be used as the new zombie's strength attribute.
    if strength >= @@max_strength
      @strength = @@max_strength
    else
      @strength = strength
    end

  end

  # Attribute Readers (getter) --------------------------------------
  def speed
    @speed
  end

  def strength
    @strength
  end

  # Attribute Writers (setter) --------------------------------------

  # Instance methods ------------------------------------------------

  def encounter
    # This method should call outrun_zombie? (see below) and survive_attack? (see also below)
    # to determine which scenario applies. In the case that you are turned into a zombie
    # (ie. you don't outrun the zombie but you aren't killed by it), create a new zombie object (that's you!)
    # and add it to the @@horde. Return outcome.

    if outrun_zombie?
      puts "Too fast to be a zombie"
    elsif survive_attack?
      puts "I'm a zombie"
      @@horde << Zombie.new(0, 0) # I'm a miserable nogoodnik zombie
      puts Zombie.all.inspect
    else
      puts "I'm killed"
    end
  end

  def outrun_zombie?
    # This instance method should use @@max_speed to generate a random number that represents how fast you manage to run from this particular zombie.
    # This method should return true if your speed is greater than the zombie's and false otherwise.
    speed = rand(@max_speed)
    if speed > @speed #=self.speed (will not work because i don't have a return method for instance zombie(n)
      return true
    else
      return false
    end
  end

  def survive_attack?
    # This instance method should use @@max_strength to generate a random number that represents how well you are able
    # to fight off this zombie. This method should return true if your strength is greater than the zombie's and false otherwise.
    strength = rand(@max_speed)
    if strength > @strength #=self.strength
      return true
    else
      return false
    end
  end

  # Class methods ---------------------------------------------------

  def self.all
    # puts "Horde composition now:"
    return @@horde
  end

  def self.new_day
    # new_day should call some_die_off, spawn, and increase_plague_level.
    self.increase_plague_level
    self.spawn
    self.some_die_off
  end

  def self.some_die_off
    rand(10).times do
      @@horde.pop while @@horde.count > 3 # condition to avoid the count of zombie in horde going below 3
    end
    puts "Now zombies in a horde are:"
    puts @@horde.count
  end

  def self.spawn
    # use @@plague_level to generate a random number and then create that number of new zombies, adding each one to @@horde.
    # Use @@max_speed and @@max_strength to generate random values for each new zombie's speed and strength.
    @@plague_level.times do |zombie|
      @@horde << Zombie.new(rand(@@max_speed), rand(@@max_strength))
    end
  end

  def self.increase_plague_level
    # This class method should generate a random number between 0 and 2
    # and increase @@plague_level by that amount.
    # puts @@plague_level
    puts @@horde.size
    puts "-----------------"
    @@plague_level += rand(@@horde.size).round(0) # Stretch 1. plague level increases is somehow based on the number of zombies in the horde
    puts "New plague level (10+zombies added) is:"
    puts @@plague_level
    return @@plague_level
  end

  def self.deadliest_zombie
    max_powers = 0
    super_zombie = ""
    Zombie.all.each do |zombie|
      if max_powers < (zombie.speed * zombie.strength)
        max_powers = zombie.speed * zombie.strength
        super_zombie = zombie.inspect
      end
    end
    puts
    puts "The deadliest_zombie is #{super_zombie}"
  end

end

# zombie1 = Zombie.new(rand(@@max_speed), rand(@@max_strength))

puts "Zombie class array:"
puts Zombie.all.inspect # []
Zombie.new_day

puts Zombie.all.inspect # [#<Zombie:0x005626ecc5ebd0 @speed=4, @strength=0>, #<Zombie:0x005626ecc5eba8 @speed=0, @strength=4>, #<Zombie:0x005626ecc5eb80 @speed=4, @strength=4>]
zombie1 = Zombie.all[0]
zombie2 = Zombie.all[1]
zombie3 = Zombie.all[2]
puts zombie1.encounter # You are now a zombie
puts zombie2.encounter # You died
puts zombie3.encounter # You died
puts Zombie.all.inspect
Zombie.increase_plague_level
Zombie.new_day
puts Zombie.all.inspect # [#<Zombie:0x005626ecc5e1f8 @speed=0, @strength=0>, #<Zombie:0x005626ecc5e180 @speed=3, @strength=3>, #<Zombie:0x005626ecc5e158 @speed=1, @strength=2>, #<Zombie:0x005626ecc5e090 @speed=0, @strength=4>]
zombie1 = Zombie.all[0]
zombie2 = Zombie.all[1]
zombie3 = Zombie.all[2]
puts zombie1.encounter # You got away
puts zombie2.encounter # You are now a zombie
puts zombie3.encounter # You died

# Stretch 2: Add a method called deadliest_zombie that returns the zombie that has the highest combination of speed and strength.
# Should this be a class method or an instance method?

Zombie.deadliest_zombie
