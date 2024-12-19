require_relative '../models/robot'
require_relative '../models/table'

x_units = rand(1..5)
y_units = rand(1..5)
table = Table.new(x_units, y_units)
x_boundaries = table.get_x_boundaries
y_boundaries = table.get_y_boundaries


RSpec.describe Robot do
  let(:table) { Table.new(rand(1..5), rand(1..5)) }
  let(:x_boundaries) { table.get_x_boundaries }
  let(:y_boundaries) { table.get_y_boundaries }

  context "when placing the robot" do
    it "does not allow placing the robot 1 unit more than the x boundaries" do
      robot = Robot.new
      robot.place(x_boundaries.max + 1, rand(y_boundaries), 0, table)

      expect(robot.x).to be_nil
      expect(robot.y).to be_nil
      expect(robot.direction).to be_nil
      expect(robot.base).to be_nil
    end

    it "does not allow placing the robot 1 unit more than the y boundaries" do
      robot = Robot.new
      robot.place(rand(x_boundaries), y_boundaries.max + 1, 0, table)

      expect(robot.x).to be_nil
      expect(robot.y).to be_nil
      expect(robot.direction).to be_nil
      expect(robot.base).to be_nil
    end

    it "allows placing the robot within the x and y boundaries" do
      robot = Robot.new
      robot.place(rand(x_boundaries), rand(y_boundaries), 0, table)

      expect(robot.x).not_to be_nil
      expect(robot.y).not_to be_nil
      expect(robot.direction).not_to be_nil
      expect(robot.base).not_to be_nil
    end
  end
end
