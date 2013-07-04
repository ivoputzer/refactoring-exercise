class Rental

  attr_reader :movie

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