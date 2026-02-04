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

# Inheritance
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "Hello!"
  end
end

class AnotherDog < Animal
  attr_accessor :name

  def initialize(color)
    # Automatically forwards args that were passed to the method which 
    # `super` is called
    super
    @color = color
  end

  # Overriding
  def speak
    # "#{self.name} says arf!"
    
    # `super` call searches the method lookup path for method with same name,
    # then invokes.
    super + " from GoodDog class"
  end
end

class Cat < Animal
end

p sparky2 = AnotherDog.new("brown")
paws = Cat.new("Buh")

puts sparky2.speak
puts paws.speak             # => Hello!

class BadDog < Animal
  def initialize(age, name)
    # Can specify the args that goes up
    # super() => Specifiy call with no args
    super(name)
    @age = age
  end
end

p BadDog.new(2, "bear")

# Mixing in Modules
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal2; end

class Fish < Animal2
  include Swimmable         # mixing in Swimmable module
end

class Mammal < Animal2
end

class Cat2 < Mammal
end

class Dog < Mammal
  include Swimmable         # mixing in Swimmable module
end

sparky = Dog.new
neemo  = Fish.new
paws   = Cat2.new

sparky.swim                 # => I'm swimming!
neemo.swim                  # => I'm swimming!
# paws.swim                   # => NoMethodError: undefined method `swim' for #<Cat:0x007fc453152308>
# Common naming convention for Ruby is to use the "able" suffix on whatever
# verb describes the behavior that the module is modeling.

# Inheritance vs Module (interface inheritance)
# Things to consider:
# - You can only subclass (class inheritance) from one class. You can mix in as
#   many modules (interface inheritance) as you'd like.
# - If an instance of class B can be described as a kind of class A, then we
#   say that B and A have a **is-a relationship**. If such a relationship
#   exists, then we probably want to use class inheritance such that class B
#   inherits from class A.
# - If class B and A do not have an is-a relationship, there may be a **has-a
#   relationship** involved. We saw has-a relationships in conjunction with
#   composition and aggregation, but such relationships also exist when
#   interface existence is desired. If you can say that class A has the
#   behaviors of type B, but B and A don't have an is-a relationship, then
#   you probably wnat to define B as a module and use interface inheritance.
# - Note that you cannot instantiate modules. In other words, objects cannont
#   be created from modules.
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable2
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal3
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end
puts "---Animal3 method lookup---"
puts Animal3.ancestors

class GoodDog2 < Animal3
  include Swimmable
  include Climbable # Last included module is looked at first
end

puts "---GoodDog2 method lookup---"
puts GoodDog2.ancestors

# More Modules
# namespacing - organizing similar classes under a module
module Mammal2
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end

buddy = Mammal2::Dog.new
kitty = Mammal2::Cat.new
buddy.speak('Arf!')           # => "Arf!"
kitty.say_name('kitty')       # => "kitty"

# Second use case - **container** for methods, called module methods
module Conversions
  def self.farenheit_to_celsius(num)
    (num - 32) * 5 / 9
  end
end
puts value = Conversions.farenheit_to_celsius(32) # preferred way
puts value = Conversions::farenheit_to_celsius(32)

# Private, Protected, and Public
# Form of Method Access Control
# public - a method that is available to anyone who knows either the class 
#          name or the object's name
# private - methods that are doing work in the class but don't need to be
#           available to the rest of the program
# protected - cannot be invoked outside the class; allow access between class
#             instances, private methods do not
class GoodDog3
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  def public_disclosure
    # As of Ruby 2.7, self.private_method is now legal
    # so self.human_years is also valid within the current object.
    "#{self.name} in human years is #{human_years}"
  end

  private # Anything below is private

  def human_years
    age * DOG_YEARS
  end
end

sparky3 = GoodDog3.new("Sparky", 4)
puts sparky3.public_disclosure
# sparky.human_years # NoMethodError: private method
# 
class Person
  def initialize(age)
    @age = age
  end

  def older?(other_person)
    age > other_person.age
  end

  protected

  attr_reader :age
end

malory = Person.new(64)
sterling = Person.new(42)

puts malory.older?(sterling)  # => true
puts sterling.older?(malory)  # => false

# malory.age # NoMethodError: protected method

# Accidental Method Overriding
# Every class is a subclass of the Object class
class Parent
  def say_hi
    p "Hi from Parent."
  end
end

Parent.superclass       # => Object
class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  # Overrides Object class send
  def send
    p "send from Child..."
  end
end

child = Child.new
child.say_hi         # => "Hi from Child."
son = Child.new
son.send :say_hi       # => wrong number of arguments (given 1, expected 0) (ArgumentError)