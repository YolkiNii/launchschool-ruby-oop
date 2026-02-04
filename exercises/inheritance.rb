# Exercise 1 
# Create a superclass called Vehicle for your MyCar class to 
# inherit from and move the behavior that isn't specific to the MyCar 
# class to the superclass. Create a constant in your MyCar class that 
# stores information about the vehicle that makes it different from 
# other types of Vehicles.
# 
# Then create a new class called MyTruck that inherits from your 
# superclass that also has a constant defined that separates it from 
# the MyCar class in some way.
# 
# Exercise 2
# Add a class variable to your superclass that can keep track of the 
# number of objects created that inherit from the superclass. Create 
# a method to print out the value of this class variable as well.
# 
# Exercise 3
# Create a module that you can mix in to ONE of your subclasses that 
# describes a behavior unique to that subclass.
# 
# Exercise 4
# Print to the screen your method lookup for the classes that you 
# have created.
# 
# Exercise 5
# Move all of the methods from the MyCar class that also pertain 
# to the MyTruck class into the Vehicle class. Make sure that all 
# of your previous method calls are working when you are finished.
# 
# Exercise 6
# Write a method called age that calls a private method to calculate 
# the age of the vehicle. Make sure the private method is not available 
# from outside of the class. You'll need to use Ruby's built-in Time 
# class to help.
# 
# Exercise 7
# Create a class 'Student' with attributes name and grade. Do NOT make 
# the grade getter public, so joe.grade will raise an error. Create a 
# better_grade_than? method, that you can call like so...

# Solution 3
module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

# Solution 1
class Vehicle
  attr_accessor :color
  attr_reader :model, :year
  # Solution 2
  @@number_of_vehicles = 0

  # Solution 2
  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  # Solution 5
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  # Solution 6
  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end

end

class MyCar < Vehicle
  # Solution 3
  include Towable

  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2

  def to_s
    "My truck  is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

# Solution 5
lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
MyCar.gas_mileage(13, 351)
lumina.spray_paint("red")
puts lumina
# Solution 4
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors
# Solution 6
puts lumina.age

# Solution 7
class Student
  attr_accessor :name

  def initialize(name, grade)
    self.name = name
    @grade = grade
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected
  
  attr_reader :grade
end

joe = Student.new("joe", 90)
bob = Student.new("bob", 80)
puts "Well done!" if joe.better_grade_than?(bob)