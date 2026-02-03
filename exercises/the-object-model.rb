# Exercise 1
# How do we create an object in Ruby? Give an example of the creation of an
# object.

# Solution 1
# We create an object by defining a class and instantiating it by using the
# `.new` method to create an instance, also known as an object.
class MyClass
end

my_obj = MyClass.new

# Exercise 2
# What is a module? What is its purpose? How do we use them with our classes?
# Create a module for the class you created in exercise 1 and include it properly.

# Solution 2
# A module allows us to group resuable code into one place. We use modules in our
# classes by using the `include` method invocation, followed by the module name.
# Modules are also used as a namespace.
module Study
end

class MyClass
  include Study
end

my_obj = MyClass.new