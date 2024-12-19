module Detectable
  attr_accessor :direction, :base

  def validate_placement(x, y, base = nil)
    base ||= @base

    validation = base.get_x_boundaries.include?(x) && base.get_y_boundaries.include?(y)

    puts 'Placement is out of coverage!' unless validation
    validation
  end

  def validate_movement(direction)
    direction ||= @direction

    validation =
      case direction
      when 0
        @base.get_y_boundaries.include?(@y+1)
      when 90
        @base.get_x_boundaries.include?(@x+1)
      when 180
        @base.get_y_boundaries.include?(@y-1)
      when 270
        @base.get_x_boundaries.include?(@x-1)
      end

    puts 'Danger Detected!' unless validation
    validation
  end
end
