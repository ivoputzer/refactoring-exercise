class Movie
  
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  
  attr_reader :price_code

  def initialize(title, price_code)
    @title, @price_code = title, set_price_code(price_code)
  end

  def set_price_code (price_code)
    case price_code
      when REGULAR
        @price = RegularPrice.new
      when CHILDRENS
        @price = ChildrensPrice.new
      when NEW_RELEASE
        @price = NewReleasePrice.new
    end
  end

  def get_price_code
    return @price_code
  end

  def get_charge (days_rented)
    return @price.get_charge(days_rented)
  end

  def get_frequent_renter_points (days_rented)
    return @price.get_frequent_renter_points(days_rented)
  end
end

class Price
  def get_frequent_renter_points(days_rented)
    return 1
  end
end

class ChildrensPrice < Price
  def get_price_code
    return Movie::CHILDRENS
  end

  def get_charge (days_rented)
    result = 0
    result += 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    return result
  end
end

class NewReleasePrice < Price
  def get_price_code
    return Movie::NEW_RELEASE
  end

  def get_frequent_renter_points(days_rented)
    return ( days_rented > 2 ) ? 2 : 1;
  end

  def get_charge (days_rented)
    result = 0
    result += days_rented * 3
    return result
  end
end

class RegularPrice < Price
  def get_price_code
    return Movie::REGULAR
  end

  def get_charge (days_rented)
    result = 0
    result += 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    return result
  end
end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def get_charge
    return @movie.get_charge(@days_rented)
  end

  def get_frequent_renter_points
    return @movie.get_frequent_renter_points(@days_rented)
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
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      # show figures for this rental
      result += "\t" + element.movie.title.to_s + "\t" + element.get_charge.to_s + "\n"
    end
    #add footer lines
    result += "Amount owed is #{self.get_total_charge}\n"
    result += "You earned #{self.get_total_frequent_renter_points} frequent renter points"
    result
  end

  def html_statement
    result = "<h1>Rentals for <em>#{@name}</em></h1>\n<p>";
    @rentals.each do |element|
      result += "#{element.movie.title.to_s} : #{element.get_charge.to_s} <br>\n";
    end 
    result += "</p>\n<p>Amount owed is <em>#{self.get_total_charge}</em></p>\n"
    result += "<p>You earned <em>#{self.get_total_frequent_renter_points}</em> frequent renter points</p>"
    return result
  end

  def get_total_charge
    result = 0
    @rentals.each do |each| 
      result += each.get_charge
    end
    return result
  end

  def get_total_frequent_renter_points
    result = 0
    @rentals.each do |each|
      result += each.get_frequent_renter_points
    end
    return result
  end

end