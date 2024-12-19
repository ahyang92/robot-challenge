module Baseable
  attr_accessor :x_origin_coordinate, :x_units, :y_origin_coordinate, :y_units

  def initialize(x_units = 0, y_units = 0)
    # technically this instantiate 'nothing' or 'no form' if no proper units provided
    @x_origin_coordinate = 0
    @y_origin_coordinate = 0

    if x_units > 0 && y_units > 0
      @x_units ||= x_unit
      @y_units ||= y_unit
    else
      @x_units = @y_units = 0
    end
  end

  def get_x_boundaries
    @x_origin_coordinate..(@x_origin_coordinate + @x_units)
  end

  def get_y_boundaries
    @y_origin_coordinate..(@y_origin_coordinate + @y_units)
  end
end
