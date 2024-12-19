module Movable
  attr_accessor :x, :y

  def initialize(x = nil, y = nil)
    @x = x
    @y = y
  end

  def move_right
    @x += 1
  end

  def move_left
    @x -= 1
  end

  def move_up
    @y += 1
  end

  def move_down
    @y -= 1
  end
end
