class RegularPrice < Price
  
  def get_price_code
    Movie::REGULAR
  end

  def get_charge (days_rented)
    (days_rented > 2) ? 2 + ((days_rented - 2) * 1.5) : 2
  end

end