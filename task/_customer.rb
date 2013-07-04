class Customer
  
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