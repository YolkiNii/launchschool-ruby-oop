# Exercise 1
# Add a class method to your MyCar class that calculates the gas mileage
# (i.e. miles per gallon) of any car.

# Exercise 2
# Override the to_s method to create a user friendly print out of your
# object.
class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end

  # Solution 1
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
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

  # Solution 2
  def to_s
    "My car is a #{color}, #{year}, #{@model}!"
  end
end

# Solution 1
MyCar.gas_mileage(13, 351)  # => "27 miles per gallon of gas"

# Solution 2
my_car = MyCar.new("2010", "Ford Focus", "silver")
puts my_car  # => My car is a silver, 2010, Ford Focus.