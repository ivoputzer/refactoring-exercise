class Price
  
  def get_points(days_rented)
    1
  end

end

class ChildrensPrice < Price
  
  def get_price_code
    Movie::CHILDRENS
  end

  def get_charge (days_rented)
    (days_rented > 3) ? 1.5 + ((days_rented - 3) * 1.5) : 1.5
  end

end

class NewReleasePrice < Price
  
  def get_price_code
    Movie::NEW_RELEASE
  end

  def get_charge (days_rented)
    days_rented * 3
  end

  def get_points(days_rented)
    (days_rented > 2) ? 2 : super.get_frequent_renter_points(days_rented);
  end

end

class RegularPrice < Price
  
  def get_price_code
    Movie::REGULAR
  end

  def get_charge (days_rented)
    (days_rented > 2) ? 2 + ((days_rented - 2) * 1.5) : 2
  end

end

class Movie

  REGULAR = 0
  
  NEW_RELEASE = 1
  
  CHILDRENS = 2

  attr_reader :title, :price_code

  def initialize(title, price_code)
    @title, @price_code = title, set_price_code(price_code)
  end

  def set_price_code (price_code) # overloading price_code setter
    case price_code
      when REGULAR
        @price = RegularPrice.new
      when CHILDRENS
        @price = ChildrensPrice.new
      when NEW_RELEASE
        @price = NewReleasePrice.new
    end
  end

  def get_charge (days_rented)
    @price.get_charge(days_rented)
  end

  def get_points (days_rented)
    @price.get_points(days_rented)
  end

end

class Rental

  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def get_charge
    @movie.get_charge(@days_rented)
  end

  def get_points
    @movie.get_points(@days_rented)
  end

end

class Customer
  
  attr_reader :name

  def initialize(name)
    @name, @rentals = name, []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def get_total_charge
    result = 0
    @rentals.each { |rental| result += rental.get_charge }
    result
  end

  def get_total_points
    result = 0
    @rentals.each { |rental| result += rental.get_points }
    result
  end

  def statement
    text = "Rental Record for #{@name}\n"
    @rentals.each { |rental| text += "\t#{rental.movie.title}\t#{rental.get_charge}\n" }
    text += "Amount owed is #{get_total_charge}\nYou earned #{get_total_points} frequent renter points"
  end

  def html_statement
    html = "<h1>Rentals for <em>#{@name}</em></h1>\n<p>";
    @rentals.each { |rental| html += "#{rental.movie.title} : #{rental.get_charge} <br>\n" }
    html += "</p>\n<p>Amount owed is <em>#{get_total_charge}</em></p>\n<p>You earned <em>#{get_total_points}</em> frequent renter points</p>"
  end

end