require_relative '../models/table'

RSpec.describe Table do
  context "when negative values are provided for x_units and y_units" do
    it "defaults to (0, 0) when x_units is negative" do
      table = Table.new(-5, 3)
      expect(table.x_units).to eq(0)
      expect(table.y_units).to eq(0)
    end

    it "defaults to (0, 0) when y_units is negative" do
      table = Table.new(3, -5)
      expect(table.x_units).to eq(0)
      expect(table.y_units).to eq(0)
    end
  end

  context "when both x_units and y_units are positive" do
    it "uses the provided values for x_units and y_units" do
      table = Table.new(5, 5)
      expect(table.x_units).to eq(5)
      expect(table.y_units).to eq(5)
    end
  end
end
