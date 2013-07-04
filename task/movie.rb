class Movie

  REGULAR = 0; NEW_RELEASE = 1; CHILDRENS = 2

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