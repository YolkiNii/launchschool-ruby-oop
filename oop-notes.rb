# Encapsulation
# 
# Idea of bundling or combining the data and the operations that work on that
# data into a single entity, e.g., an object.
# 
# - hides functionality
# - data protection: data cannot be manipulated or changed without obvious
#     intent
# - objects expose a public interface for interacting with other objects

# Polymorphism
# 
# Ability for different types of data to respond to a common interface.
# 
# - think of move() for a human, cat, etc.

# Inheritance
# Class inherits(acquires) behaviors of another class, the superclass.
# Class that inherit are subclasses.
# 
# - Module is another form
#   - CANNOT create obj with a module
#   - use method invocation *include* to *mixin*
#   

# Think of classes as molds that can produce objects(instances).

# Define class
class GoodDog
end

sparky = GoodDog.new # instantiation -creating a new object

# Module
module Speak
  def speak(sound)
    puts sound
  end
end

class SomeDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = SomeDog.new
sparky.speak("Arf!")        # => Arf!
bob = HumanBeing.new
bob.speak("Hello!")         # => Hello!

# ancestors
puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors

# With multiple method sign, closet ancestor takes prio for call

# Object state => instance vars
# Object behavior => instance methods - defined in class

# *initialize* method - gets called every time your create a new obj.
# - gets triggered by *new* class method
# 
# @ symbol => instance variable
# - instance vars live until object instance is destroyed
class GooderDog
  def initialize(name) # constructor
    @name = name
    puts "This object was initialized!"
  end
end

sparky = GooderDog.new("Sparky") # => "This object was initialized!"

# Composition and Aggregation
# - design principles used tot establish relationships between classes

# Composition
# - object(container) contains one or more objs of other classes as part of
#   state
# - composed objs are created when container is created and destroyed when
#   container is destroyed
# - **has-a relationship**
# container "has a" composed obj
class Engine
  def start
    puts "Engine starting..."
  end
end

class Car
  def initialize
    @engine = Engine.new  # Engine instance is created when Car is created
  end

  def start
    @engine.start
  end
end

my_car = Car.new
my_car.start  # Engine is an integral part of Car

# Aggregation
# - lifetime of contained objs does not depend on lifetime of container
# - container may have reference to objs, and may coordinate their operations
# - also **has-a relationship** to its aggregated objs
class Passenger
end

class Car
  def initialize(passengers)
    @passengers = passengers  # Passengers are given to the Car at creation
  end
end

# Passengers can exist without Car
passengers = [Passenger.new, Passenger.new]
my_car = Car.new(passengers)

# Instance Methods and Accessor Methods
# Class Variables
# Constants
class GoodestDog
  DOG_YEARS = 7 # constants, need to begin with a capital, but all uppercase more conventional

  @@number_of_dogs = 0 # Class variable

  attr_accessor :name, :height, :weight, :age# Auto create *getter* and *setter*
  # only need getter => `attr_reader`
  # only need setter => `attr_writer`
  # all `attr_*` take Symbol obj as arg
  
  puts self # => GoodestDog (class name)
  # self - inside instance method, refer the instance that called method
  # self - outside of instance method, refer the class and can be used to
  #        define class methods

  def initialize(n, h = 1, w = 1, a = 1)
    # @name = n
    # @height = h
    # @weight = w
    
    # Calling setter
    self.name = n
    self.height = h
    self.weight = w
    self.age  = a * DOG_YEARS
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs # Use self for class medthod definitions
    @@number_of_dogs
  end

  # def name # Getter Accessor
  #   @name
  # end

  # # Setter methods always return the value that is passed in as arg
  # def name=(name) # Setter Accessor
  #   @name = name
  #   "Laddieboy"              # value will be ignored
  # end

  def speak
    "#{@name} says arf!" # expose info about state of the obj
  end

  def change_info(n, h, w)
    # Calling setter
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  # Overriding Ruby's default
  # If the override doesn't return a string, it will ignore the non-string
  # and look at inheritance chain for another version.
  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end

  # Refereces the calling object
  def what_is_self 
    self
  end
end

sparky = GoodestDog.new("Sparky")
puts sparky.speak
puts sparky.name # Calling getter
# Ruby syntax sugar for `sparkyname=("Spartacus")`
puts("Setter call => #{sparky.name = 'Spartacus'}")
puts sparky.name

fido = GoodestDog.new("Fido")
puts fido.speak           

# `puts sparky.name` => NoMethodError

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info 

puts GoodestDog.total_number_of_dogs # => 2
puts sparky # Calls the to_s instance method
puts "In String Interpolation: #{sparky}" # Works in string interpolation
p sparky.what_is_self