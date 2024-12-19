require_relative '../concerns/baseable'

class Table
  include Baseable

  def initialize(x_units, y_units)
    if x_units > 0 && y_units > 0
      @x_units = x_units
      @y_units = y_units
    end
    super
  end
end
