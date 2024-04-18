# CSE 337 Assignment 2
# Taein Um
# SBU_email: taein.um@stonybrook.edu
# ID: 112348159

class Vehicle
  @@number_of_vehicles = 0

  # Initialize a new Vehicle object
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1 # Increment the total number of vehicles
  end

  # Display the total number of vehicles created
  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  # Increase the vehicle's speed
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  # Decrease the vehicle's speed
  def brake(number)
    if @current_speed == 0
      puts "Your car is not moving."
    else
      @current_speed -= number
      if @current_speed <= 0
        @current_speed = 0
        puts "Your car stopped."
      else
        puts "You push the brake and decelerate #{number} mph."
      end
    end
  end

  # Print the current speed of the vehicle
  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  # Stop the vehicle
  def shut_down
    @current_speed = 0
    puts "Let's park #{self.class}!"
  end

  # Change the vehicle's color
  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  # Calculate gas mileage
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  # Accessor and reader methods
  attr_accessor :color
  attr_reader :year, :model
end


module Towable
  # Check if the vehicle can tow a certain weight
  def can_tow?(pounds)
    pounds < 2000
  end
end


class MyCar < Vehicle
  include Towable

  NUMER_OF_DOORS = 4

  # Override to_s method to provide custom string representation of a car
  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}!"
  end
end



class MyTruck < Vehicle
  include Towable

  NUMER_OF_DOORS = 2

  # Override to_s method to provide custom string representation of a truck
  def to_s
    "My truck is a #{self.color}, #{self.year}, #{self.model}!"
  end
end
