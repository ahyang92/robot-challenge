require_relative '../helper'
require_relative '../concerns/movable'
require_relative '../concerns/detectable'

class Robot
  include Movable
  include Detectable

  attr_accessor :direction, :base

  def initialize
    super
    @direction = @base = nil
  end

  def place(x, y, direction, base)
    if validate_placement(x, y, base)
      @x = x
      @y = y
      @direction = direction
      @base = base
    end
  end

  def base=(base)
    # TODO: Add validation here to confirm this is a compatible base when there is more 'bases' supported e.g floor, round table, etc
    # Consider validation as another module/helper
    @base = base
  end

  def move
    if validate_movement(@direction)
      case @direction
      when 0
        move_up
      when 90
        move_right
      when 180
        move_down
      when 270
        move_left
      end
    end
  end


  # This is lateral rotation / xy plane (for now)
  # Use degree to leave room for potential expansion
  def rotate(degree = 0)
    @direction += degree.round
    @direction = @direction.remainder(360)
    @direction = 360 + @direction if @direction.negative?

    # KISS for now. Hardset direction to 0, 90, 180, 270 for early supports
    case @direction
    when 45..134
      @direction = 90
    when 135..224
      @direction = 180
    when 225..314
      @direction = 270
    when 315..360, 0..44
      @direction = 0
    end
  end

  def report
    puts "Output: #{@x},#{@y},#{convert_direction_to_full_name(@direction)}"
  end
end
