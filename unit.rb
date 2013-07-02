require "./task"

require "test/unit"
 
class UnitTest < Test::Unit::TestCase

  def test_a_single_movie

      customer = Customer.new :Ivo

      rental1 = Rental.new (Movie.new :Armageddon, Movie::REGULAR), 5

      customer.add_rental rental1

      assert_equal("Rental Record for Ivo\n\tArmageddon\t6.5\nAmount owed is 6.5\nYou earned 1 frequent renter points", customer.statement)

  end

  def test_a_single_movie_html

      customer = Customer.new :Ivo

      rental1 = Rental.new (Movie.new :Armageddon, Movie::REGULAR), 5

      customer.add_rental rental1

      assert_equal("<h1>Rentals for <em>Ivo</em></h1>\n<p>Armageddon : 6.5 <br>\n</p>\n<p>Amount owed is <em>6.5</em></p>\n<p>You earned <em>1</em> frequent renter points</p>", customer.html_statement)

  end

  def test_multiple_movies

      customer = Customer.new :Ivo

      rental1 = Rental.new (Movie.new :Armageddon, Movie::REGULAR), 5

      rental2 = Rental.new (Movie.new :Shrek, Movie::CHILDRENS), 6

      rental3 = Rental.new (Movie.new :Armageddon, Movie::NEW_RELEASE), 3

      customer.add_rental rental1

      customer.add_rental rental2

      customer.add_rental rental3

      assert_equal("Rental Record for Ivo\n\tArmageddon\t6.5\n\tShrek\t6.0\n\tArmageddon\t9\nAmount owed is 21.5\nYou earned 4 frequent renter points", customer.statement)

  end

# # # # TODO
#
#  def test_multiple_movies_html
#
#      customer = Customer.new :Ivo
#
#      rental1 = Rental.new (Movie.new :Armageddon, Movie::REGULAR), 5
#
#      rental2 = Rental.new (Movie.new :Shrek, Movie::CHILDRENS), 6
#
#      rental3 = Rental.new (Movie.new :Armageddon, Movie::NEW_RELEASE), 3
#
#      customer.add_rental rental1
#
#      customer.add_rental rental2
#
#      customer.add_rental rental3
#
#      assert_equal("Rental Record for Ivo\n\tArmageddon\t6.5\n\tShrek\t6.0\n\tArmageddon\t9\nAmount owed is 21.5\nYou earned 4 frequent renter points", customer.statement)
#
#  end

end