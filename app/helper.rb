def puts_robot_ascii
  puts_assets('app/assets/robot_ascii.txt')
  puts "\n"
end

def puts_help_menu
  puts_assets('app/assets/help_menu.txt')
  puts "\n"
end

def puts_assets(file_path)
  if File.exists?(file_path)
    # Read the contents of the file and puts it to the console
    help_text = File.read(file_path)
    puts help_text
  else
    puts "Help menu file not found!"
  end
end

def directions_map
  {'N' => 0, 'S' => 180, 'E' => 90, 'W' => 270}
end

def convert_direction_to_degree(direction_in_alphabet)
  directions_map[direction_in_alphabet]
end

def convert_direction_to_alphabet(direction_in_degree)
  directions_map.key(direction_in_degree) unless direction_in_degree.nil?
end

def convert_direction_to_full_name(direction_in_degree)
  {'NORTH' => 'N', 'SOUTH' => 'S', 'EAST' => 'E', 'WEST' => 'W'}.key(convert_direction_to_alphabet(direction_in_degree))
end
