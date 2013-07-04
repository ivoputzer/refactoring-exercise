require "./task/price"

class ChildrensPrice

  include Price
  
  def get_price_code
    Movie::CHILDRENS
  end

  def get_charge (days_rented)
    (days_rented > 3) ? 1.5 + ((days_rented - 3) * 1.5) : 1.5
  end

end