require "./task/price" # needs to be loaded

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