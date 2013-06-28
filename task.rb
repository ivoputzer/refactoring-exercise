class Movie
  
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_reader :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end
end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def get_charge

    result = 0

    case self.movie.price_code

      when Movie::REGULAR
        result += 2
        result += (self.days_rented - 2) * 1.5 if self.days_rented > 2
      
      when Movie::NEW_RELEASE
        result += self.days_rented * 3
      
      when Movie::CHILDRENS
        result += 1.5
        result += (self.days_rented - 3) * 1.5 if self.days_rented > 3
    end

    return result

  end

  def get_frequent_renter_points
    # add bonus for a two day new release rental
    if self.movie.price_code == Movie::NEW_RELEASE && self.days_rented > 1
        return 2
    else
        return 1
    end
  end

end

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|

      frequent_renter_points += element.get_frequent_renter_points

      # show figures for this rental
      result += "\t" + element.movie.title.to_s + "\t" + element.get_charge.to_s + "\n"
      total_amount += element.get_charge
    end
    #add footer lines
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end

end